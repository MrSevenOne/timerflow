import 'package:timerflow/config/theme/ligth_theme.dart';
import 'package:timerflow/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: ApiConstant.supabaseUrl,
    anonKey: ApiConstant.supabaseAnonKey,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => TableViewModel(TableRepository(TableService()))),
        ChangeNotifierProvider(
            create: (_) => FoodViewModel(FoodRepository(FoodService()))),
        ChangeNotifierProvider(
            create: (_) => DrinkViewModel(DrinkRepository(DrinkService()))),
        ChangeNotifierProvider(
            create: (_) =>
                OrderViewModel(repository: OrderRepository(OrderService()))),
        ChangeNotifierProvider(
            create: (_) =>
                SessionViewModel(SessionRepository(SessionService()))),
        ChangeNotifierProvider(
            create: (_) =>
                PaymentViewModel(PaymentRepository(PaymentService()))),
        ChangeNotifierProvider(
            create: (_) => SessionReportViewModel(
                SessionReportRepository(SessionReportService()))),
        ChangeNotifierProvider(
            create: (_) => DrinkReportViewModel(
                DrinkReportRepository(DrinkReportService()))),
        ChangeNotifierProvider(
            create: (_) => FoodReportViewModel(
                FoodReportRepository(service: FoodReportService()))),
        ChangeNotifierProvider(
            create: (_) => AuthViewModel(AuthRepository(AuthService()))),
        ChangeNotifierProvider(
            create: (_) => UserViewmodel(UserRepository(UserService()))),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(
          create: (_) => CheckoutViewModel(PaymentService()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeVM = Provider.of<ThemeViewModel>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: localeProvider.locale, // <-- til bu yerda o‘qiladi
      fallbackLocale: const Locale('en', 'US'),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeVM.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: AppRoutes.signUp,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
