import 'package:flutter/material.dart';
import 'package:timerflow/%20presentation/screens/add_order_page.dart';
import 'package:timerflow/%20presentation/screens/auth/auth_gate.dart';
import 'package:timerflow/%20presentation/screens/auth/login_page.dart';
import 'package:timerflow/%20presentation/screens/auth/singup_page.dart';
import 'package:timerflow/%20presentation/screens/home_page.dart';
import 'package:timerflow/%20presentation/screens/order_page.dart';
import 'package:timerflow/%20presentation/screens/drink_page.dart';
import 'package:timerflow/%20presentation/screens/foods_page.dart';
import 'package:timerflow/%20presentation/screens/payment_page.dart';
import 'package:timerflow/%20presentation/screens/session_page.dart';
import 'package:timerflow/%20presentation/screens/tables_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String tables = '/TablePage';
  static const String foods = '/FoodPage';
  static const String drinks = '/DrinkPage';
  static const String order = '/OrderPage';
  static const String session = '/SessionPage';
  static const String addOrder = '/AddOrderPage';
  static const String payment = '/PaymentPage';
  static const String login = '/LoginPage';
  static const String signUp = '/SignUp';
  static const String authGate = '/AuthGate';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => HomePage(),
    tables: (context) => const TablePage(),
    foods: (context) => const FoodPage(),
    drinks: (context) => const DrinkPage(),
    login: (context) => LoginPage(),
    signUp: (context) => SignupPage(),
    authGate: (context)=> AuthGate(),
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
      case addOrder:
        final arg = settings.arguments as int;
        return MaterialPageRoute(
            builder: (context) => AddOrderPage(
                  sessionId: arg,
                ));

      case payment:
        final arg = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => PaymentPage(sessionId: arg),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const TablePage(), // fallback
        );
    }
  }
}
