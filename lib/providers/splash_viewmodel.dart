import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/providers/service/user_viewmodel.dart';
import 'package:timerflow/repositories/tables/usertariff_repository.dart';
import 'package:timerflow/routing/app_router.dart';
import 'package:timerflow/providers/service/user_tariff_viewmodel.dart';
import 'package:timerflow/services/remote/tables/usertariff_service.dart';

class SplashViewModel extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;
  final UserTariffViewModel userTariffViewModel = UserTariffViewModel(
      service: UserTariffService(repository: UserTariffRepository()));
  final UserViewModel userViewModel = UserViewModel();

  SplashViewModel();

  String? _targetRoute;
  String? get targetRoute => _targetRoute;

  /// Login statusiga va tarifga obuna bo‘lishga qarab target route aniqlaydi
  Future<void> handleStartupLogic() async {
    final session = _client.auth.currentSession;

    if (session == null) {
      // User login qilmagan → Login page
      _targetRoute = AppRouter.auth;
      notifyListeners();
      return;
    }

    // UserTariff mavjudligini tekshirish
    final hasTariff = await userTariffViewModel.hasUserTariffForCurrentUser();
    debugPrint("User tarifda bormi: $hasTariff");

    //userni statusni tekshirish
    final userStatus = await userViewModel.getUserStatus();
    debugPrint("User statusi: $userStatus");

    // ignore: unrelated_type_equality_checks
    if (hasTariff && userStatus) {
      // User tarifga obuna bo‘lgan va status true → Home page
      _targetRoute = AppRouter.rootNavigation;
    } else if (hasTariff == false) {
      // User tarifga obuna bo‘lmagan → Tariff page
      _targetRoute = AppRouter.tariff;
    } else {
      // User status false → Connect Admin page
      _targetRoute = AppRouter.connectAdmin;
    }

    notifyListeners();
  }
}
