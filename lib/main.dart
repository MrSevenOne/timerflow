import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/%20presentation/providers/bar_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/drink_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/food_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/session_viewmodel.dart';
import 'package:timerflow/config/constant/api_constant.dart';
import 'package:timerflow/%20presentation/providers/tables_viewmodel.dart';
import 'package:timerflow/data/repositories/database/drink_repository.dart';
import 'package:timerflow/data/repositories/database/food_repository.dart';
import 'package:timerflow/data/repositories/database/session_repository.dart';
import 'package:timerflow/data/repositories/database/tables_repository.dart';
import 'package:timerflow/data/services/supabase/database/drink_service.dart';
import 'package:timerflow/data/services/supabase/database/food_service.dart';
import 'package:timerflow/data/services/supabase/database/session_service.dart';
import 'package:timerflow/routers/app_routers.dart';

import 'data/services/supabase/database/tables_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: ApiConstant.supabaseUrl,
    anonKey: ApiConstant.supabaseAnonKey,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TableViewModel(TableRepository(TableService())),
          ),
          ChangeNotifierProvider(
          create: (_) => FoodViewModel(FoodRepository(FoodService()))
          ),
           ChangeNotifierProvider(
          create: (_) => DrinkViewModel(DrinkRepository(DrinkService()),),
          ),
          ChangeNotifierProvider(
          create: (_) => BarViewModel(),
          ),
          ChangeNotifierProvider(
          create: (_) => SessionViewModel(SessionRepository(SessionService())),
          )
      ],
      child: MaterialApp(
        title: 'TimerFlow',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
           initialRoute: AppRoutes.home,
            routes: AppRoutes.routes,
            onGenerateRoute: AppRoutes.onGenerateRoute, // bu yerda o'zingizning start page bo'lishi mumkin
      ),
    );
  }
}
