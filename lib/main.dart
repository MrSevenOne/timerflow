import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:timerflow/core/connectivity_manager.dart';
import 'package:timerflow/models/table_model.dart';
import 'package:timerflow/providers/auth/auth_viewmodel.dart';
import 'package:timerflow/providers/bottom_nav_provider.dart';
import 'package:timerflow/providers/service/table_viewmodel.dart';
import 'package:timerflow/providers/service/tariff_viewmodel.dart';
import 'package:timerflow/providers/service/user_tariff_viewmodel.dart';
import 'package:timerflow/providers/theme_viewmodel.dart';
import 'package:timerflow/repositories/tables/table_repository.dart';
import 'package:timerflow/repositories/tables/usertariff_repository.dart';
import 'package:timerflow/routing/app_router.dart';
import 'package:timerflow/services/remote/tables/table_supabase_service.dart';
import 'package:timerflow/services/remote/tables/usertariff_service.dart';
import 'package:timerflow/utils/theme/light_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1️⃣ Hive init
  await Hive.initFlutter();

  // 2️⃣ Adapter register
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(TableModelAdapter());
  }

  // 3️⃣ Hive box’larini ochish
  final tablesBox = await Hive.openBox<TableModel>('tables');
  final settingsBox = await Hive.openBox<String>('settings');

  // 4️⃣ Supabase init
  await Supabase.initialize(
    url: 'https://gfguahgevksybisiwrlt.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdmZ3VhaGdldmtzeWJpc2l3cmx0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM4MjExNTIsImV4cCI6MjA3OTM5NzE1Mn0.fAHBMvtLesfQHC9vwENSkCmhlk6xwi1AbyKQlu4Mvws',
  );

  // 6️⃣ EasyLocalization init
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('uz'),
        Locale('ru'),
      ],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: MyApp(
        tablesBox: tablesBox,
        settingsBox: settingsBox,
      ),
    ),
  );
}

// --- MyApp with dependency injection for Hive boxes ---
class MyApp extends StatelessWidget {
  final Box<TableModel> tablesBox;
  final Box<String> settingsBox;

  const MyApp({
    super.key,
    required this.tablesBox,
    required this.settingsBox,
  });

  @override
  Widget build(BuildContext context) {
    final supabaseService = TableSupabaseService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TariffViewModel()),
        ChangeNotifierProvider(
          create: (_) => TableViewModel(
            repository: TableRepository(
              tablesBox: tablesBox,
              settingsBox: settingsBox,
              supabaseService: supabaseService,
            ),
          ),
        ),
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
            initialRoute: AppRouter.splash,
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
