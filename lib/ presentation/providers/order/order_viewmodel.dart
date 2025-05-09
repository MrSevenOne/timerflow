import 'package:flutter/material.dart';
import 'package:timerflow/data/repositories/database/order_repository.dart';
import 'package:timerflow/domain/models/orders_model.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderRepository repository;
  OrderViewModel({required this.repository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<OrderDrinkModel> _drinkOrders = [];
  List<OrderDrinkModel> get drinkOrders => _drinkOrders;

  List<OrderFoodModel> _foodOrders = [];
  List<OrderFoodModel> get foodOrders => _foodOrders;

  // umumiy narxni olish
  int get totalOrderPrice => totalDrinkPrice + totalFoodPrice;
  // drinkni umumiy narxini olish
  int get totalDrinkPrice {
  return _drinkOrders.fold(0, (sum, item) => sum + (item.drinkModel!.price * item.quantity));
}
// foodni umumiy narxini olish
int get totalFoodPrice {
  return _foodOrders.fold(0, (sum, item) => sum + (item.foodModel!.price * item.quantity));
}


  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  // ================= Drink Orders =================

  Future<void> fetchAllDrinkOrders() async {
    _setLoading(true);
    try {
      _drinkOrders = await repository.getAllDrinkOrders();
      _setError(null);
    } catch (e) {
      _setError('Ichimlik buyurtmalarini olishda xatolik: $e');
    }
    _setLoading(false);
  }

 Future<void> fetchDrinkOrdersBySessionId(int sessionId) async {
  _setLoading(true);
  try {
    _drinkOrders = await repository.getDrinkOrdersBySessionId(sessionId);
    _setError(null);
    notifyListeners(); // <-- BU MUHIM
  } catch (e) {
    _setError('Session uchun ichimlik buyurtmalarini olishda xatolik: $e');
  }
  _setLoading(false);
}


  Future<void> addDrinkOrder({required OrderDrinkModel order}) async {
    _setLoading(true);
    try {
      await repository.addDrinkOrder(order);
      await fetchDrinkOrdersBySessionId(order.sessionId);
    } catch (e) {
      _setError('Ichimlik buyurtmasini qo‘shishda xatolik: $e');
    }
    _setLoading(false);
  }

  Future<void> deleteDrinkOrder(int id, int sessionId) async {
    _setLoading(true);
    try {
      await repository.deleteDrinkOrder(id);
      await fetchDrinkOrdersBySessionId(sessionId);
    } catch (e) {
      _setError('Ichimlik buyurtmasini o‘chirishda xatolik: $e');
    }
    _setLoading(false);
  }

  // ================= Food Orders =================

  Future<void> fetchAllFoodOrders() async {
    _setLoading(true);
    try {
      _foodOrders = await repository.getAllFoodOrders();
      _setError(null);
    } catch (e) {
      _setError('Ovqat buyurtmalarini olishda xatolik: $e');
    }
    _setLoading(false);
  }

Future<void> fetchFoodOrdersBySessionId(int sessionId) async {
  _setLoading(true);
  try {
    _foodOrders = await repository.getFoodOrdersBySessionId(sessionId);
    _setError(null);
    notifyListeners(); // <-- BU HAM
  } catch (e) {
    _setError('Session uchun ovqat buyurtmalarini olishda xatolik: $e');
  }
  _setLoading(false);
}


  Future<void> addFoodOrder({required OrderFoodModel order}) async {
    _setLoading(true);
    try {
      await repository.addFoodOrder(order);
      await fetchFoodOrdersBySessionId(order.sessionId);
    } catch (e) {
      _setError('Ovqat buyurtmasini qo‘shishda xatolik: $e');
    }
    _setLoading(false);
  }

  Future<void> deleteFoodOrder(int id, int sessionId) async {
    _setLoading(true);
    try {
      await repository.deleteFoodOrder(id);
      await fetchFoodOrdersBySessionId(sessionId);
    } catch (e) {
      _setError('Ovqat buyurtmasini o‘chirishda xatolik: $e');
    }
    _setLoading(false);
  }
}
