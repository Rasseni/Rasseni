import 'package:flutter/material.dart';

class BottomNavBarController extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  selectedScreen(index) {
    _currentIndex = index;
    notifyListeners();
  }
}
