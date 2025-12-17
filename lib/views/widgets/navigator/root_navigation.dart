import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/presentation/screens/table_screen.dart';
import 'package:timerflow/presentation/viewmodel/bottom_nav_provider.dart';
import 'package:timerflow/utils/extension/theme_extension.dart';
import 'package:timerflow/views/responsive.dart';
import 'package:timerflow/views/screens/auth/auth_screen.dart';

class RootNavigation extends StatelessWidget {
  const RootNavigation({super.key});

  // Sahifalar ro'yxati
  static final List<Widget> _pages = [
    const TablesScreen(),
    const TablesScreen(),
    const AuthScreen(),
  ];

  // Navigation elementlari (label + icon)
  static final List<NavigationDestination> _destinations = [
    const NavigationDestination(icon: Icon(Icons.home_outlined), label: "Home"),
    const NavigationDestination(icon: Icon(Icons.search), label: "Search"),
    const NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BottomNavProvider>();

    return ResponsiveLayout(
      // Mobile: bottom NavigationBar (O'zgarmadi)
      mobile: Scaffold(
        body: _pages[provider.index],
        bottomNavigationBar: NavigationBar(
          selectedIndex: provider.index,
          onDestinationSelected: provider.setIndex,
          destinations: _destinations,
        ),
      ),

      // Tablet: yon NavigationRail (O'zgarmadi)
      tablet: Scaffold(
        body: _pages[provider.index],
        bottomNavigationBar: NavigationBar(
          selectedIndex: provider.index,
          onDestinationSelected: provider.setIndex,
          destinations: _destinations,
        ),
      ),

      // Desktop: Yuqori (Web) Navigation
      desktop: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Timer Flow"),
          // **ACTIONS bo'limida gorizontal navigatsiya yaratish**
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: Row(
                children: _destinations.asMap().entries.map((entry) {
                  int idx = entry.key;
                  NavigationDestination dest = entry.value;
                  // Navigatsiya tugmasi
                  return Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: TextButton.icon(
                      onPressed: () => provider.setIndex(idx),
                      icon: dest.icon,
                      label: Text(dest.label),
                      // Hozirgi tanlangan elementni vizual ajratib ko'rsatish
                      style: TextButton.styleFrom(
                        foregroundColor: provider.index == idx
                            ? context.theme.primaryColor // Tanlangan rang
                            : context.theme.colorScheme.shadow, // Oddiy rang
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        body: _pages[provider.index],
      ),
    );
  }
}
