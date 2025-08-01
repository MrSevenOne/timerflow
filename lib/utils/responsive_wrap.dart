import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveWrap extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final EdgeInsets padding;

  const ResponsiveWrap({
    super.key,
    required this.children,
    this.spacing = 12.0,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final breakpoints = ResponsiveBreakpoints.of(context);
        final isDesktop = breakpoints.isDesktop;
        final isTablet = breakpoints.isTablet;

        int columns;
        if (isDesktop) {
          columns = 3;
        } else if (isTablet) {
          columns = 2;
        } else {
          columns = 1;
        }

        final totalSpacing = spacing * (columns - 1);
        final itemWidth = (width - totalSpacing - padding.horizontal) / columns;

        return SingleChildScrollView(
          padding: padding,
          child: Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: children.map((child) {
              return SizedBox(width: itemWidth, child: child);
            }).toList(),
          ),
        );
      },
    );
  }
}
