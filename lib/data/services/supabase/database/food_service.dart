import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/domain/models/food_model.dart';

class FoodService {
  final _client = Supabase.instance.client;
  final String tableName = 'food';

  // GET by user ID
  Future<List<FoodModel>> fetchFood() async {
  final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('User ID topilmadi');

    final response = await _client
        .from(tableName)
        .select()
        .eq('user_id', userId)
        .order('name');

    return (response as List).map((e) => FoodModel.fromJson(e)).toList();
  }

  // ADD
  Future<void> addFood({required FoodModel foodModel}) async {
    await _client.from(tableName).insert(foodModel.toJson());
  }

  // UPDATE
  Future<void> updateFood({required FoodModel foodModel}) async {
    await _client
        .from(tableName)
        .update(foodModel.toJson())
        .eq('id', foodModel.id!);
  }

  // Update amount after ordering
  Future<void> updateAmountFood({
    required int foodId,
    required int orderedQuantity,
  }) async {
    final response = await _client
        .from(tableName)
        .select('amount')
        .eq('id', foodId)
        .single();

    final int currentAmount = response['amount'];

    if (orderedQuantity > currentAmount) {
      throw Exception('Yetarli miqdor mavjud emas');
    }

    final int newAmount = currentAmount - orderedQuantity;

    await _client
        .from(tableName)
        .update({'amount': newAmount})
        .eq('id', foodId);
  }

  // DELETE
  Future<void> deleteFood({required int foodId}) async {
    await _client.from(tableName).delete().eq('id', foodId);
  }
}
