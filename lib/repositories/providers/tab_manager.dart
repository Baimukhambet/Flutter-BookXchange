import 'package:flutter/material.dart';

class TabManagerProvider extends ChangeNotifier {
  int currentIndex = 0;

  void changeTab(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}
