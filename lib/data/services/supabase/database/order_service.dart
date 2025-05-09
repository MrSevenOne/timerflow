import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/domain/models/orders_model.dart';

class OrderService {
  final supabase = Supabase.instance.client;
  final orderDrinkTable = 'order_drinks';
  final orderFoodTable = 'order_foods';

  // ============= Drink ====================

  // Barcha Drink buyurtmalarni olish
  Future<List<OrderDrinkModel>> getAllDrinkOrders() async {
    try {
      final response =
          await supabase.from(orderDrinkTable).select('*,drink(*)');
      debugPrint('getAllDrinkOrders fetched: $response');
      return (response as List<dynamic>)
          .map((e) => OrderDrinkModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint('Error fetching getAllDrinkOrders: $e');
      rethrow;
    }
  }

  // Session bo'yicha Drink buyurtmalarni olish
  Future<List<OrderDrinkModel>> getDrinkOrdersBySessionId(int sessionId) async {
    try {
      final response = await supabase
          .from(orderDrinkTable)
          .select('*,drink(*)')
          .eq('session_id', sessionId);
      debugPrint(
          'getDrinkOrdersBySessionId for session $sessionId fetched: $response');
      return (response as List<dynamic>)
          .map((e) => OrderDrinkModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint('Error fetching getDrinkOrdersBySessionId: $e');
      rethrow;
    }
  }

 // Yangi yoki mavjud DrinkOrder ni qo'shish va quantity ni oshirish
Future<void> addDrinkOrder(OrderDrinkModel order) async {
  try {
    // Avval mavjud yozuvni tekshir
    final existing = await supabase
        .from(orderDrinkTable)
        .select()
        .eq('session_id', order.sessionId)
        .eq('drink_id', order.drinkId)
        .maybeSingle();

    if (existing != null) {
      // Mavjud bo‘lsa, quantity ni oshirib yangilash
      final updatedQuantity = (existing['quantity'] as int) + order.quantity;
      await supabase.from(orderDrinkTable).update({
        'quantity': updatedQuantity,
      }).eq('id', existing['id']);

      debugPrint('Drink order updated (quantity increased): session_id=${order.sessionId}, drink_id=${order.drinkId}, new quantity=$updatedQuantity');
    } else {
      // Mavjud bo‘lmasa, yangi yozuv qo‘shish
      await supabase.from(orderDrinkTable).insert(order.toJson());
      debugPrint('New drink order added: ${order.toJson()}');
    }
  } catch (e) {
    debugPrint('Error in addDrinkOrder (with check): $e');
    rethrow;
  }
}


  // DrinkOrder yangilash
  Future<void> updateDrinkOrder(int id, OrderDrinkModel order) async {
    try {
      await supabase
          .from(orderDrinkTable)
          .update(order.toJson())
          .eq('id', id);
      debugPrint('updateDrinkOrder updated: $id');
    } catch (e) {
      debugPrint('Error updating updateDrinkOrder: $e');
      rethrow;
    }
  }

  // DrinkOrder o'chirish
  Future<void> deleteDrinkOrder(int id) async {
    try {
      await supabase.from(orderDrinkTable).delete().eq('id', id);
      debugPrint('deleteDrinkOrder deleted: $id');
    } catch (e) {
      debugPrint('Error deleting deleteDrinkOrder: $e');
      rethrow;
    }
  }

  // ============= Food ====================

  // Barcha Food buyurtmalarni olish
  Future<List<OrderFoodModel>> getAllFoodOrders() async {
    try {
      final response =
          await supabase.from(orderFoodTable).select('*,food(*)');
      debugPrint('getAllFoodOrders fetched: $response');
      return (response as List<dynamic>)
          .map((e) => OrderFoodModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint('Error fetching getAllFoodOrders: $e');
      rethrow;
    }
  }

  // Session bo'yicha Food buyurtmalarni olish
  Future<List<OrderFoodModel>> getFoodOrdersBySessionId(int sessionId) async {
    try {
      final response = await supabase
          .from(orderFoodTable)
          .select('*,food(*)')
          .eq('session_id', sessionId);
      debugPrint(
          'getFoodOrdersBySessionId for session $sessionId fetched: $response');
      return (response as List<dynamic>)
          .map((e) => OrderFoodModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint('Error fetching getFoodOrdersBySessionId: $e');
      rethrow;
    }
  }

  // Yangi FoodOrder qo'shish
Future<void> addFoodOrder(OrderFoodModel order) async {
  try {
    // Avval mavjud yozuvni tekshir
    final existing = await supabase
        .from(orderFoodTable)
        .select()
        .eq('session_id', order.sessionId)
        .eq('food_id', order.foodId)
        .maybeSingle();

    if (existing != null) {
      // Mavjud bo‘lsa, quantity ni oshirib yangilash
      final updatedQuantity = (existing['quantity'] as int) + order.quantity;
      await supabase.from(orderFoodTable).update({
        'quantity': updatedQuantity,
      }).eq('id', existing['id']);

      debugPrint('Food order updated (quantity increased): session_id=${order.sessionId}, food_id=${order.foodId}, new quantity=$updatedQuantity');
    } else {
      // Mavjud bo‘lmasa, yangi yozuv qo‘shish
      await supabase.from(orderFoodTable).insert(order.toJson());
      debugPrint('New food order added: ${order.toJson()}');
    }
  } catch (e) {
    debugPrint('Error in addFoodOrder (with check): $e');
    rethrow;
  }
}


  // FoodOrder yangilash
  Future<void> updateFoodOrder(int id, OrderFoodModel order) async {
    try {
      await supabase
          .from(orderFoodTable)
          .update(order.toJson())
          .eq('id', id);
      debugPrint('updateFoodOrder updated: $id');
    } catch (e) {
      debugPrint('Error updating updateFoodOrder: $e');
      rethrow;
    }
  }

  // FoodOrder o'chirish
  Future<void> deleteFoodOrder(int id) async {
    try {
      await supabase.from(orderFoodTable).delete().eq('id', id);
      debugPrint('deleteFoodOrder deleted: $id');
    } catch (e) {
      debugPrint('Error deleting deleteFoodOrder: $e');
      rethrow;
    }
  }
}
