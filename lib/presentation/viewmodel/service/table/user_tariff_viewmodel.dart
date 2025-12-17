import 'package:flutter/material.dart';
import 'package:timerflow/models/user_tariff_model.dart';
import 'package:timerflow/data/remote/supabase/tables/usertariff_service.dart';

class UserTariffViewModel extends ChangeNotifier {
  final UserTariffService service;

  UserTariffViewModel({required this.service});

  final List<UserTariffModel> _tariffs = [];
  List<UserTariffModel> get tariffs => _tariffs;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // UPSERT: create yoki update bitta metod bilan
  Future<void> upsert(UserTariffModel userTariff) async {
    _isLoading = true;
    notifyListeners();

    try {
      final updatedTariff = await service.upsertUserTariff(userTariff);

      // listda mavjud bo‘lsa update, yo‘q bo‘lsa add
      final index = _tariffs.indexWhere((t) => t.id == updatedTariff.id);
      if (index != -1) {
        _tariffs[index] = updatedTariff;
      } else {
        _tariffs.add(updatedTariff);
      }

      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  //has User in UserTariff table
  Future<bool> hasUserTariffForCurrentUser() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Service return qilayotgan bool qiymatni to‘g‘ri olamiz
      final result = await service.hasUserTariff();

      _errorMessage = null;
      return result; // <-- shu yerda real true/false qaytadi
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // delete
  Future<void> delete(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final success = await service.deleteUserTariff(id);
      if (success) {
        _tariffs.removeWhere((t) => t.id == id);
      }
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
