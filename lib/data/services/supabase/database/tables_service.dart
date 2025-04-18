import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/domain/models/table_model.dart';

class TablesService {
  final SupabaseClient client = Supabase.instance.client;
  final String tableName = 'tables';

  // CREATE
  Future<void> createTable({required table}) async {
    try {
      await client.from(tableName).insert(table.toJson());
    } catch (e) {
      throw Exception('Failed to create table: $e');
    }
  }

// READ
  Future<List<TableModel>> getAllTables() async {
    try {
      final response = await client.from(tableName).select();
      final data = List<Map<String, dynamic>>.from(response);
      return data.map((map) => TableModel.fromJson(map)).toList();
    } catch (e) {
      throw Exception('Failed to fetch tables: $e');
    }
  }

  // UPDATE
  Future<void> updateTable({required id, required updatedTable}) async {
    try {
      await client.from(tableName).update(updatedTable.toJson()).eq('id', id);
    } catch (e) {
      throw Exception('Failed to update table: $e');
    }
  }

  // DELETE
  Future<void> deleteTable({required int id}) async {
    try {
      await client.from(tableName).delete().eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete table: $e');
    }
  }
  // STATUS UPDATE
Future<void> updateTableStatus({required int tableId, required String newStatus}) async {
  try {
    await client
        .from(tableName)
        .update({'status': newStatus})
        .eq('id', tableId);
  } catch (e) {
    throw Exception('Failed to update table status: $e');
  }
}

}
