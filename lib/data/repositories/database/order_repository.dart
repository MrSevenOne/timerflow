import 'package:timerflow/data/services/supabase/database/order_service.dart';
import 'package:timerflow/domain/models/orders_model.dart';

class OrderRepository {
  final OrderService service;
  OrderRepository(this.service);

  // ============= DRINKS ====================

  // Barcha drink buyurtmalarni olish
  Future<List<OrderDrinkModel>> getAllDrinkOrders() =>
      service.getAllDrinkOrders();

  // Session bo'yicha drink buyurtmalarni olish
  Future<List<OrderDrinkModel>> getDrinkOrdersBySessionId(int sessionId) =>
      service.getDrinkOrdersBySessionId(sessionId);

  // Drink order qo'shish
  Future<void> addDrinkOrder(OrderDrinkModel order) =>
      service.addDrinkOrder(order);

  // Drink order o'chirish
  Future<void> deleteDrinkOrder(int id) => service.deleteDrinkOrder(id);

  // ============= FOODS ====================

  // Barcha food buyurtmalarni olish
  Future<List<OrderFoodModel>> getAllFoodOrders() =>
      service.getAllFoodOrders();

  // Session bo'yicha food buyurtmalarni olish
  Future<List<OrderFoodModel>> getFoodOrdersBySessionId(int sessionId) =>
      service.getFoodOrdersBySessionId(sessionId);

  // Food order qo'shish
  Future<void> addFoodOrder(OrderFoodModel order) =>
      service.addFoodOrder(order);

  // Food order o'chirish
  Future<void> deleteFoodOrder(int id) => service.deleteFoodOrder(id);
}
