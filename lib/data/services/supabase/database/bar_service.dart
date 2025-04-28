import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/domain/models/order_model.dart';

class BarService {
  final _client = Supabase.instance.client;
  final String tableName = 'bar';

  Future<List<BarModel>> fetchBars() async {
    final response = await _client
        .from(tableName)
        .select('id, drinks(*), foods(*)')
        .order('id');

    

    return response.map((e) => BarModel.fromJson(e)).toList();
  }

  Future<void> addBar(BarModel bar) async {
    final insertData = {
      'drinks': bar.drink.id,
      'foods': bar.food.id,
    };
    await _client.from(tableName).insert(insertData);
  }

  Future<void> updateBar(BarModel bar) async {
    final updateData = {
      'drinks': bar.drink.id,
      'foods': bar.food.id,
    };
    await _client.from(tableName).update(updateData).eq('id', bar.id as Object);
  }

  Future<void> deleteBar(int id) async {
    await _client.from(tableName).delete().eq('id', id);
  }
}
