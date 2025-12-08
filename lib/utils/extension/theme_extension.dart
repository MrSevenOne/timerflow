import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/providers/theme_viewmodel.dart';

extension ThemeExtension on BuildContext {
  // current ThemeData
  ThemeData get theme => Theme.of(this);

  // isDark boolean
  bool get isDarkTheme => read<ThemeProvider>().isDark;

  // toggle theme
  void toggleTheme() => read<ThemeProvider>().toggleTheme();
}
