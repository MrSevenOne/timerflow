import 'package:flutter/material.dart';
import 'package:timerflow/%20presentation/screens/bar_page.dart';
import 'package:timerflow/%20presentation/screens/drink_page.dart';
import 'package:timerflow/%20presentation/screens/foods_page.dart';
import 'package:timerflow/%20presentation/screens/session_page.dart';
import 'package:timerflow/%20presentation/screens/tables_page.dart';

import 'package:timerflow/domain/models/session_model.dart'; // <-- model import qilish kerak

class AppRoutes {
  static const String home = '/';
  static const String foods = '/FoodPage';
  static const String drinks = '/DrinkPage';
  static const String bar = '/BarPage';
  static const String session = '/SessionPage';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const TablePage(),
    foods: (context) => const FoodPage(),
    drinks: (context) => const DrinkPage(),
    bar: (context) => const BarPage(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case session:
        final args = settings.arguments as SessionModel; // <-- argumentsni olish
        return MaterialPageRoute(
          builder: (context) => SessionPage(sessionModel: args),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const TablePage(), // fallback
        );
    }
  }
}
