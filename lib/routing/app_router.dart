import 'package:flutter/material.dart';
import 'package:timerflow/views/connect_admin/connect_admin_screen.dart';
import 'package:timerflow/views/screens/auth/auth_screen.dart';
import 'package:timerflow/views/screens/home/home_screen.dart';
import 'package:timerflow/views/screens/tariff/tariff_screen.dart';
import 'package:timerflow/views/splash/splash_screen.dart';
import 'package:timerflow/views/widgets/navigator/root_navigation.dart';

class AppRouter {
  // Route names
  static const String splash = '/';
  static const String rootNavigation = '/rootNavigation';
  static const String auth = '/auth';
  static const String home = '/home';
  static const String tariff = '/tariff';
  static const String table = '/table';
  static const String connectAdmin = "/connectAdmin";

  // Route generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case rootNavigation:
        return MaterialPageRoute(
          builder: (_) => RootNavigation(),
        );
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case auth:
        return MaterialPageRoute(builder: (_) => AuthScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case tariff:
        return MaterialPageRoute(builder: (_) => const TariffScreen());
      // case table:
      //   return MaterialPageRoute(builder: (_) => TableScreen());
      case connectAdmin:
        return MaterialPageRoute(builder: (_) => const ConnectAdminPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
