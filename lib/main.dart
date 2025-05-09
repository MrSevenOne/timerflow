import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/%20presentation/providers/auth/auth_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/auth/user_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/drink/drink_report_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/food/food_report_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/order/order_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/drink/drink_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/food/food_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/payment_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/session/session_report_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/session/session_viewmodel.dart';
import 'package:timerflow/config/constant/api_constant.dart';
import 'package:timerflow/%20presentation/providers/tables_viewmodel.dart';
import 'package:timerflow/data/repositories/database/auth/auth_repository.dart';
import 'package:timerflow/data/repositories/database/auth/user_repository.dart';
import 'package:timerflow/data/repositories/database/drink_report_repository.dart';
import 'package:timerflow/data/repositories/database/drink_repository.dart';
import 'package:timerflow/data/repositories/database/food_report_repository.dart';
import 'package:timerflow/data/repositories/database/food_repository.dart';
import 'package:timerflow/data/repositories/database/order_repository.dart';
import 'package:timerflow/data/repositories/database/payment_repository.dart';
import 'package:timerflow/data/repositories/database/session_report_repository.dart';
import 'package:timerflow/data/repositories/database/session_repository.dart';
import 'package:timerflow/data/repositories/database/tables_repository.dart';
import 'package:timerflow/data/services/supabase/database/auth/auth_service.dart';
import 'package:timerflow/data/services/supabase/database/auth/user_service.dart';
import 'package:timerflow/data/services/supabase/database/drink_report_service.dart';
import 'package:timerflow/data/services/supabase/database/drink_service.dart';
import 'package:timerflow/data/services/supabase/database/food_report_service.dart';
import 'package:timerflow/data/services/supabase/database/food_service.dart';
import 'package:timerflow/data/services/supabase/database/order_service.dart';
import 'package:timerflow/data/services/supabase/database/payment_service.dart';
import 'package:timerflow/data/services/supabase/database/session_report_service.dart';
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
          create: (_) => OrderViewModel(repository: OrderRepository(OrderService())),
          ),
          ChangeNotifierProvider(
          create: (_) => SessionViewModel(SessionRepository(SessionService())),
          ),
          ChangeNotifierProvider(create: (_)=> PaymentViewModel(PaymentRepository(PaymentService())),
          ),
          ChangeNotifierProvider(create: (_)=> SessionReportViewModel(SessionReportRepository(SessionReportService()),),
          ),
          ChangeNotifierProvider(create: (_)=> DrinkReportViewModel(DrinkReportRepository(DrinkReportService(),),),
          ),
          ChangeNotifierProvider(create: (_)=>FoodReportViewModel(FoodReportRepository(service: FoodReportService(),),),
          ),
          ChangeNotifierProvider(create: (_) => AuthViewModel(AuthRepository(AuthService(),),),
          ),
          ChangeNotifierProvider(create: (_) => UserViewmodel(UserRepository(UserService(),),),),
      ],
      child: MaterialApp(
        title: 'TimerFlow',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
           initialRoute: AppRoutes.authGate,
            routes: AppRoutes.routes,
            onGenerateRoute: AppRoutes.onGenerateRoute, // bu yerda o'zingizning start page bo'lishi mumkin
      ),
    );
  }
}
