import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DM/userDM.dart';
import '../authentication/signIn/signIn.dart';
import '../firebase_service/firestore/firestore_service.dart';
import '../main_layout/main_layout.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return SignIn();
      }
        final uid = snapshot.data!.uid;

        return FutureBuilder<UserDM?>(
          future: FirestoreService.getUserFromFirestore(uid),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (userSnapshot.hasError) {
              return  SignIn();
            }

            UserDM.currentUser = userSnapshot.data;
            return const MainLayout();
          },
        );
      },
    );
  }
}