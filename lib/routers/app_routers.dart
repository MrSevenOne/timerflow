import 'package:flutter/material.dart';
import 'package:timerflow/%20presentation/screens/drink_page.dart';
import 'package:timerflow/%20presentation/screens/foods_page.dart';
import 'package:timerflow/%20presentation/screens/tables_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String foods = '/FoodPage';
  static const String reports = '/reports';
  static const String drinks = 'DrinkPage';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const TablePage(),
    foods: (context) => const FoodPage(),
    drinks: (context) => const DrinkPage(),
  };
}
