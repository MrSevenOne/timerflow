import 'package:flutter/material.dart';
import 'package:timerflow/%20presentation/connect_admin.dart';
import 'package:timerflow/%20presentation/screens/auth/auth_gate.dart';
import 'package:timerflow/%20presentation/screens/auth/login/login_page.dart';
import 'package:timerflow/%20presentation/screens/auth/singup_page.dart';
import 'package:timerflow/%20presentation/screens/reports/bar_report_page.dart';
import 'package:timerflow/%20presentation/screens/home/home_page.dart';
import 'package:timerflow/%20presentation/screens/reports/paymentreport_page.dart';
import 'package:timerflow/%20presentation/screens/reports/tablereport_page.dart';
import 'package:timerflow/%20presentation/screens/tariffs_select_page.dart';

import 'package:timerflow/%20presentation/splash_page.dart';

class AppRoutes {
  static const String home = '/HomePage';
  static const String tariff = '/TariffPage';
  static const String tables = '/TablePage';
  static const String foods = '/FoodPage';
  static const String drinks = '/DrinkPage';
  static const String order = '/OrderPage';
  static const String session = '/SessionPage';
  static const String addOrder = '/AddOrderPage';
  static const String payment = '/PaymentPage';
  static const String paymentreport = '/PaymentReportPage';
  static const String login = '/LoginPage';
  static const String signUp = '/SignUp';
  static const String authGate = '/AuthGate';
  static const String tableReport = '/TableReportPage';
  static const String barReport = '/BarReportPage';
  static const String settings = '/SettingsPage';
  static const String splash = '/SplashPage';
  static const String contactAdmin = "/ContactAdminPage";

  static Map<String, WidgetBuilder> routes = {
    login: (context) => LoginPage(),
    signUp: (context) => SignupPage(),
    authGate: (context) => AuthGate(),
    home: (context) => HomePage(),
    splash: (context) => SplashPage(),
    tariff: (context) => TariffPage(),
    contactAdmin: (context) => ContactAdminPage(),
    tableReport: (context) => TableReportPage(),
    paymentreport: (context) => PaymentReportPage(),
    barReport: (context) => BarReportPage(),
  };

  // static Route<dynamic> onGenerateRoute(RouteSettings settings) {
  //   switch (settings.name) {

  //     case addOrder:
  //       final arg = settings.arguments as int;
  //       return MaterialPageRoute(
  //           builder: (context) => AddOrderPage(
  //                 sessionId: arg,
  //               ));

  //     case payment:
  //       final arg = settings.arguments as int;
  //       return MaterialPageRoute(
  //         builder: (context) => PaymentPage(sessionId: arg),
  //       );
  //     default:
  //       return MaterialPageRoute(
  //         builder: (context) => const TablePage(), // fallback
  //       );
  //   }
  // }
}
