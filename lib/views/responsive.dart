import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  /// Optional custom breakpoints
  final double tabletBreakpoint;
  final double desktopBreakpoint;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
    this.tabletBreakpoint = 600,
    this.desktopBreakpoint = 1024,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    if (width >= desktopBreakpoint) {
      return desktop;
    } else if (width >= tabletBreakpoint) {
      return tablet;
    } else {
      return mobile;
    }
  }
}
