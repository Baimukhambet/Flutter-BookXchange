import 'package:cubit_test/my_bottom_bar.dart';
import 'package:cubit_test/features/auth/login_screen.dart';
import 'package:cubit_test/features/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MyBottomBar();
        }
        return LoginScreen();
      },
    );
  }
}
