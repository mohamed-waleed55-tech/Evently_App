import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DM/userDM.dart';
import '../core/firebase_service/firestore/firestore_service.dart';
import '../features/authentication/signIn/screen/signIn.dart';
import '../features/main_layout/screen/main_layout.dart';
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {


        if (authSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!authSnapshot.hasData) {

          return SignIn();
        }

        final uid = authSnapshot.data!.uid;

        return FutureBuilder<UserDM?>(
          future: FirestoreService.getUserFromFirestore(uid),
          builder: (context, userSnapshot) {

            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (userSnapshot.hasError) {
              return const Center(child: Text("Something went wrong"));
            }
            if (!userSnapshot.hasData || userSnapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            UserDM.currentUser = userSnapshot.data!;

            return const MainLayout();
          },
        );
      },
    );
  }
}