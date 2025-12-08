import 'package:flutter/foundation.dart';
import 'package:timerflow/models/tariff_model.dart';
import 'package:timerflow/services/remote/tables/tariff_service.dart';

class TariffViewModel extends ChangeNotifier {
  final TariffService _service = TariffService();

  bool isLoading = false;
  List<TariffModel> tariffs = [];
  String? errorMessage;

  // Selected index
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // 🔥 Selected Tariff getter
  TariffModel? get selectedTariff =>
      (tariffs.isNotEmpty) ? tariffs[_selectedIndex] : null;

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> fetchTariffs() async {
    try {
      _setLoading(true);
      tariffs = await _service.fetchTariffs();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }
}
