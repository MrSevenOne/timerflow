import 'package:flutter/material.dart';
import 'package:timerflow/%20presentation/screens/order_page.dart';
import 'package:timerflow/%20presentation/screens/drink_page.dart';
import 'package:timerflow/%20presentation/screens/foods_page.dart';
import 'package:timerflow/%20presentation/screens/session_page.dart';
import 'package:timerflow/%20presentation/screens/tables_page.dart';


class AppRoutes {
  static const String home = '/';
  static const String foods = '/FoodPage';
  static const String drinks = '/DrinkPage';
  static const String order = '/OrderPage';
  static const String session = '/SessionPage';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const TablePage(),
    foods: (context) => const FoodPage(),
    drinks: (context) => const DrinkPage(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case session:
        final args = settings.arguments as int; // <-- argumentsni olish
        return MaterialPageRoute(
          builder: (context) => SessionPage(tableId: args),
        );
      case order:
        final arg = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => OrderPage(sessionId: arg),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const TablePage(), // fallback
        );
    }
  }
}
