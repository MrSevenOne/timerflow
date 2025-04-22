
import 'package:timerflow/domain/models/food_model.dart';
import 'package:timerflow/data/services/supabase/database/food_service.dart';

class FoodRepository {
  final FoodService _service;

  FoodRepository(this._service);

  Future<List<FoodModel>> getAllFood() async {
    return await _service.fetchFood();
  }

  Future<void> addFood(FoodModel foodModel) async {
    await _service.addFood(foodModel: foodModel);
  }

  Future<void> updateFood(FoodModel foodModel) async {
    await _service.updateFood(foodModel: foodModel);
  }

  Future<void> deleteFood(int id) async {
    await _service.deleteFood(foodId: id);
  }
}
