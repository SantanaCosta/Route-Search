import 'package:flutter/material.dart';

class NavigationController with ChangeNotifier {
  int _currentIndex = 0;
  late Function(int) _onPageChanged;

  int get currentIndex => _currentIndex;

  void setup({
    required int initialIndex,
    required Function(int) onPageChanged,
  }) {
    _currentIndex = initialIndex;
    _onPageChanged = onPageChanged;
  }

  void navigateToPage(int index) {
    _currentIndex = index;
    _onPageChanged(_currentIndex);
    notifyListeners();
  }
}
