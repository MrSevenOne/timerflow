import 'package:timerflow/exports.dart';

class TariffProvider extends ChangeNotifier {
  final TariffService _tariffService;
  final UserService _userService = UserService(); 

  TariffProvider(this._tariffService);

  List<TariffModel> _tariffs = [];
  TariffModel? _selectedTariff;
  bool _isLoading = false;
  String? _error;

  List<TariffModel> get tariffs => _tariffs;
  TariffModel? get selectedTariff => _selectedTariff;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchTariffs() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _tariffs = await _tariffService.getAllTariffs();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectTariff(TariffModel tariff) {
    _selectedTariff = tariff;
    notifyListeners();
  }

  /// Tanlangan tarifni hozirgi foydalanuvchiga yozish
  Future<void> updateUserTariff() async {
    if (_selectedTariff == null) return;

    try {
      final userModel = await _userService.fetchCurrentUserInfo();

      if (userModel == null) throw 'Foydalanuvchi topilmadi';
      final now = DateTime.now();

      final tariffEndDate = now.add(Duration(days: _selectedTariff!.durationDays));


      final updatedUser = userModel.copyWith(
        tariffId: _selectedTariff!.id,
        tariffStartDate: DateTime.now(),
        tariffEndDate: tariffEndDate,
      );

      await _userService.updateUser(userModel: updatedUser);
    } catch (e) {
      debugPrint('Tarifni yozishda xatolik: $e');
      rethrow;
    }
  }
}
