import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/domain/models/food_model.dart';

class FoodService {
  final _client = Supabase.instance.client;
  final String tableName = 'food';

  // GET
  Future<List<FoodModel>> fetchFood() async {
    final response = await _client.from(tableName).select().order('name');
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

  // DELETE
  Future<void> deleteFood({required int foodId}) async {
    await _client.from(tableName).delete().eq('id', foodId);
  }
}
