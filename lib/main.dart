import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/core/connectivity_manager.dart';
import 'package:timerflow/providers/auth/auth_viewmodel.dart';
import 'package:timerflow/providers/bottom_nav_provider.dart';
import 'package:timerflow/providers/service/table_viewmodel.dart';
import 'package:timerflow/providers/service/tariff_viewmodel.dart';
import 'package:timerflow/providers/service/user_tariff_viewmodel.dart';
import 'package:timerflow/providers/theme_viewmodel.dart';
import 'package:timerflow/repositories/tables/usertariff_repository.dart';
import 'package:timerflow/routing/app_router.dart';
import 'package:timerflow/services/remote/tables/usertariff_service.dart';
import 'package:timerflow/utils/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  WidgetsFlutterBinding.ensureInitialized();
  // 2. Tinglovchini ishga tushirish
  ConnectivityManager().startListening();

  // Easy Localization init
  await EasyLocalization.ensureInitialized();

  // Supabase init
  await Supabase.initialize(
    url: 'https://gfguahgevksybisiwrlt.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdmZ3VhaGdldmtzeWJpc2l3cmx0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM4MjExNTIsImV4cCI6MjA3OTM5NzE1Mn0.fAHBMvtLesfQHC9vwENSkCmhlk6xwi1AbyKQlu4Mvws',
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('uz'),
        Locale('ru'),
      ],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TariffViewModel()),
        ChangeNotifierProvider(create: (_) => TableViewModel()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(
          create: (_) => UserTariffViewModel(
            service: UserTariffService(
              repository: UserTariffRepository(),
            ),
          ),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'TimerFlow',
            debugShowCheckedModeBanner: false,
            initialRoute:
                AppRouter.splash, // ✅ initialRoute ni string qilib yozing**
            onGenerateRoute: AppRouter.generateRoute,
            navigatorKey: navigatorKey,
            theme: lightTheme,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          );
        },
      ),
    );
  }
}
