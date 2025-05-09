import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/domain/models/drink_model.dart';

class DrinkService {
  final _client = Supabase.instance.client;
  final String tableName = 'drink';

  Future<List<DrinkModel>> fetchDrinks() async {
  final userId = _client.auth.currentUser?.id;
  if (userId == null) {
    throw Exception('User not logged in');
  }

  final response = await _client
      .from(tableName)
      .select()
      .eq('user_id', userId)
      .order('name');

  return (response as List).map((e) => DrinkModel.fromJson(e)).toList();
}


  Future<void> addDrink(DrinkModel drink) async {
    await _client.from(tableName).insert(drink.toJson());
  }

  Future<void> updateDrink(DrinkModel drink) async {
    await _client.from(tableName).update(drink.toJson()).eq('id', drink.id!);
  }

  Future<void> deleteDrink(int id) async {
    await _client.from(tableName).delete().eq('id', id);
  }


    Future<void> updateAmountDrink({
    required int drinkId,
    required int orderedQuantity,
  }) async {
    final response = await _client
        .from(tableName)
        .select('amount')
        .eq('id', drinkId)
        .single();

    final int currentAmount = response['amount'];

    if (orderedQuantity > currentAmount) {
      throw Exception('Yetarli miqdor mavjud emas');
    }

    final int newAmount = currentAmount - orderedQuantity;

    await _client
        .from(tableName)
        .update({'amount': newAmount})
        .eq('id', drinkId);
  }

}