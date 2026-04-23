import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/firebase_service/firestore/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../DM/userDM.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static Future<String?> register(
    String email,
    String password,
    String name,
  ) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      FirestoreService.addUserToFirestore(
        UserDM(
          id: FirebaseAuth.instance.currentUser!.uid,
          name: name,
          email: email,
          favouriteEventsIds: [],
        ),
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return "error";
    }
  }

  static Future<String?> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final firebaseUser = credential.user;

      if (firebaseUser == null) {
        return "Login failed";
      }

      final userDM = await FirestoreService.getUserFromFirestore(
        firebaseUser.uid,
      );
      UserDM.currentUser = userDM;

      if (userDM == null) {
        return "User data not found";
      }

      return null;
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    } catch (e) {
      return "Something went wrong";
    }
  }

  static Future<String?> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());

      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credential':
          return "Invalid email format";

        default:
          return "Failed to send reset email";
      }
    } catch (e) {
      return "Something went wrong";
    }
  }

  static String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return "Invalid email format";

      case 'invalid-credential':
        return "Email or password is incorrect";

      default:
        return "Login failed";
    }
  }

  static Future<void> logout() async {
    UserDM.currentUser = null;
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();


  }

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null) {
        try {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .set({
                "id": user.uid,
                "name": user.displayName ?? "",
                "email": user.email ?? "",
                "favouriteEventsIds": [],
              }, SetOptions(merge: true));
        } catch (e) {
          print("Firestore write error: $e");
        }
      }

      return userCredential;
    } catch (e) {
      print("Google sign-in error: $e");
      return null;
    }
  }
}
