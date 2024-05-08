import 'package:cubit_test/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  AuthService authService = AuthService.shared;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text(authService.getCurrentUser()!.email!),
      actions: [
        IconButton(
          onPressed: () => authService.signOut(),
          icon: Icon(Icons.logout),
        )
      ],
    ));
  }
}
