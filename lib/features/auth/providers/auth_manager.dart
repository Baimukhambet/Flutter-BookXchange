import 'package:flutter/material.dart';

class AuthManager extends ChangeNotifier {
  AuthType currentType = AuthType.login;

  void changeType(AuthType toType) {
    currentType = toType;
    notifyListeners();
  }
}

enum AuthType { register, login }
