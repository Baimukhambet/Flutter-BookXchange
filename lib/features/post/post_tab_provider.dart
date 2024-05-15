import 'package:flutter/material.dart';

class PostTabProvider extends ChangeNotifier {
  int currentIndex = 0;

  void nextPage() {
    currentIndex += 1;
    notifyListeners();
  }

  void prevPage() {
    currentIndex -= 1;
    notifyListeners();
  }

  void change(int val) {
    currentIndex = val;
    debugPrint(val.toString());
    notifyListeners();
  }
}
