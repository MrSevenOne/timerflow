import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timerflow/ui/auth/widgets/login_screen.dart';
import 'package:timerflow/ui/auth/widgets/signup_screen.dart';
import 'package:timerflow/ui/home/home_screen.dart';
import 'package:timerflow/ui/splash/widgets/splash_screen.dart';
import 'package:timerflow/ui/table_add/widgets/table_add_screen.dart';
import 'package:timerflow/ui/widget/mainscaffold.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String mainScaffold = '/mainScaffold';
  static const String addTable = '/addTable';
  static const String signUp = '/signUp';
  static const String login = 'login';

  /// **Statik marshrutlar**
  static Map<String, WidgetBuilder> routes = {
    splash: (context) => SplashScreen(),
    home: (context) => HomeScreen(), // home sahifasi qo‘shildi
    addTable: (context) => TableAddScreen(),
    signUp: (context) => SignUpScreen(),
    login: (context) => LoginScreen(),
    mainScaffold: (context) => MainScaffold(),
  };

  /// **Animatsiyali yo‘nalishlar**
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 700),
          child: SplashScreen(),
        );
      case home:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 700),
          child: HomeScreen(),
        );
      case addTable:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 700),
          child: TableAddScreen(),
        );
      default:
        return null;
    }
  }
}
