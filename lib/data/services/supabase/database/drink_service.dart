import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/domain/models/drink_model.dart';

class DrinkService {
  final _client = Supabase.instance.client;
  final String tableName = 'drink';

  Future<List<DrinkModel>> fetchDrinks() async {
    final response = await _client.from(tableName).select().order('name');
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
}
