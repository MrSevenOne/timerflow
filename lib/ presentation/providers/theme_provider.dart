import 'package:flutter/material.dart';

class ThemeViewModel extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // View'ga o'zgarishlarni yuborish
  }
}