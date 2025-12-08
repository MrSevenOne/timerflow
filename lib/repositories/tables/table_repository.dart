import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/table_model.dart';

class TableRepository {
  final _client = Supabase.instance.client;

  final String tableName = 'tables';

  /// Get all tables
  Future<List<TableModel>> fetchTables() async {
    final response = await _client
        .from(tableName)
        .select()
        .order('id', ascending: true);

    return (response as List).map((e) => TableModel(
      serverId: e['id'],
      name: e['name'],
      type: e['type'],
      hourPrice: e['hour_price'],
      isActive: e['is_active'],
      createdAt: DateTime.tryParse(e['created_at'] ?? ''),
      updatedAt: DateTime.tryParse(e['updated_at'] ?? ''),
      userId: e['user_id'],
    )).toList();
  }

  /// Insert table
  Future<TableModel?> insertTable(TableModel table) async {
    final response = await _client.from(tableName).insert({
      'name': table.name,
      'type': table.type,
      'hour_price': table.hourPrice,
      'is_active': table.isActive,
      'user_id': table.userId,
    }).select().single();

    return TableModel(
      serverId: response['id'],
      name: response['name'],
      type: response['type'],
      hourPrice: response['hour_price'],
      isActive: response['is_active'],
      createdAt: DateTime.tryParse(response['created_at'] ?? ''),
      updatedAt: DateTime.tryParse(response['updated_at'] ?? ''),
      userId: response['user_id'],
    );
  }

  /// Update table
  Future<bool> updateTable(int id, TableModel table) async {
    await _client.from(tableName).update({
      'name': table.name,
      'type': table.type,
      'hour_price': table.hourPrice,
      'is_active': table.isActive,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', id);

    return true;
  }

  /// Delete table
  Future<bool> deleteTable(int id) async {
    await _client.from(tableName).delete().eq('id', id);
    return true;
  }
}
