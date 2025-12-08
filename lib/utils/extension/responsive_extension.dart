import 'package:flutter/material.dart';

extension ResponsiveExtension on BuildContext {
  /// Ekran kengligini olish
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Mobile / Tablet / Desktop o'lchamlar bo'yicha qiymat qaytaradi
  double responsiveValue({
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (screenWidth >= 1024) return desktop; // Desktop
    if (screenWidth >= 600) return tablet;  // Tablet
    return mobile;                           // Mobile
  }
}
