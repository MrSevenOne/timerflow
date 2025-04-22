import 'package:flutter/material.dart';
import 'package:timerflow/data/repositories/database/food_repository.dart';
import 'package:timerflow/domain/models/food_model.dart';

class FoodViewModel extends ChangeNotifier {
  final FoodRepository _repository;

  FoodViewModel(this._repository);

  List<FoodModel> _foodList = [];
  bool _isLoading = false;
  String? _error;

  List<FoodModel> get foodList => _foodList;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Ma'lumotlarni olish
  Future<void> getFood() async {
    _setLoading(true);
    try {
      _foodList = await _repository.getAllFood();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Qo‘shish
  Future<void> addFood(FoodModel foodModel) async {
    try {
      await _repository.addFood(foodModel);
      await getFood();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Tahrirlash
  Future<void> updateFood(FoodModel foodModel) async {
    try {
      await _repository.updateFood(foodModel);
      await getFood();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // O‘chirish
  Future<void> deleteFood(int id) async {
    try {
      await _repository.deleteFood(id);
      _foodList.removeWhere((item) => item.id == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
