
import 'package:responsive_framework/responsive_framework.dart';
import 'package:timerflow/%20presentation/providers/auth/user_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/checkout_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/order_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/payment_provider.dart';
import 'package:timerflow/%20presentation/providers/payment_report_provider.dart';
import 'package:timerflow/%20presentation/providers/product_report_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/session_provider.dart';
import 'package:timerflow/%20presentation/providers/table_report_provider.dart';
import 'package:timerflow/config/theme/ligth_theme.dart';
import 'package:timerflow/domain/models/product_report_model.dart';
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
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider(UserService())),
        ChangeNotifierProvider(create: (_) => TariffProvider(TariffService())),
        ChangeNotifierProvider(create: (_)=> TableProvider(TableService(),)),
        ChangeNotifierProvider(create: (_)=> ProductViewModel(ProductService())),
        ChangeNotifierProvider(create: (_)=> OrderViewModel()),
        ChangeNotifierProvider(create: (_)=> TableReportViewModel(TableReportService())),
        ChangeNotifierProvider(create: (_) => PaymentViewModel(PaymentService())),
        ChangeNotifierProvider(create: (_) => ProductReportViewModel()),
        ChangeNotifierProvider(create: (_)=>UserViewmodel(UserService())),

        ChangeNotifierProvider(create: (_)=> CheckoutViewModel(
          tableReportVM: TableReportViewModel(TableReportService()), 
          paymentVM: PaymentViewModel(PaymentService()), 
        tableProvider: TableProvider(TableService()),
        productReportViewModel: ProductReportViewModel(),
        orderViewModel: OrderViewModel(),
        )),
        ChangeNotifierProvider(create: (_)=>PaymentReportViewModel()),
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
      locale: localeProvider.locale,
      fallbackLocale: const Locale('en', 'US'),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeVM.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
       builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
    );
  }
}
