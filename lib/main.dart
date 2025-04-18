import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/config/constants.dart';
import 'package:timerflow/routing/router.dart';
import 'package:timerflow/ui/auth/view_model/session_viewmodel.dart';
import 'package:timerflow/utils/theme/light_theme.dart';

import 'ui/auth/view_model/tables_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: ApiConstants.baseUrl,
    anonKey: ApiConstants.anonKey,
  );

   runApp(
    ScreenUtilInit(
      designSize: Size(375, 812),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TablesViewModel()),
          ChangeNotifierProvider(create: (_) => SessionViewModel()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 956), // Figma yoki UI dizayn asosida belgilanadi
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: LightTheme, // endi bu yerda chaqiriladi, muammo bo‘lmaydi
          initialRoute: AppRoutes.mainScaffold,
          routes: AppRoutes.routes,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        );
      },
    );
  }
}
