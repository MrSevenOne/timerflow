import 'package:flutter/material.dart';
import 'package:timerflow/data/repositories/database/drink_repository.dart';
import 'package:timerflow/domain/models/drink_model.dart';

class DrinkViewModel extends ChangeNotifier {
  final DrinkRepository _repository;

  DrinkViewModel(this._repository);

  List<DrinkModel> _drinkList = [];
  bool _isLoading = false;
  String? _error;

  List<DrinkModel> get drinkList => _drinkList;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Loading holatini o‘zgartirish
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Ichimliklarni olish
  Future<void> getDrinks() async {
    _setLoading(true);
    try {
      _drinkList = await _repository.getAllDrinks();
      print(_drinkList.toList());
      _error = null;
    } catch (e) {
      _error = e.toString();
      print(_error);
    } finally {
      _setLoading(false);
    }
  }

  // Ichimlik qo‘shish
  Future<void> addDrink(DrinkModel drinkModel) async {
    try {
      await _repository.addDrink(drinkModel);
      await getDrinks();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Ichimlikni yangilash
  Future<void> updateDrink(DrinkModel drinkModel) async {
    try {
      await _repository.updateDrink(drinkModel);
      await getDrinks();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Ichimlikni o‘chirish
  Future<void> deleteDrink(int id) async {
    try {
      await _repository.deleteDrink(id);
      _drinkList.removeWhere((drink) => drink.id == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
