import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/domain/models/table_model.dart';

class TableService {
  final _client = Supabase.instance.client;
  final String tableName = 'tables';
//GET
  Future<List<TableModel>> fetchTables() async {
    final response = await _client.from(tableName).select().order('number');

    return (response as List).map((e) => TableModel.fromJson(e)).toList();
  }

//ADD
  Future<void> addTable({required TableModel tableModel}) async {
    await _client.from(tableName).insert(tableModel.toJson());
  }

//UPDATE
  Future<void> updateTable({required TableModel tableModel}) async {
    await _client
        .from(tableName)
        .update(tableModel.toJson())
        .eq('id', tableModel.id!);
  }

//DELETE
  Future<void> deleteTable({required int tableId}) async {
    await _client.from(tableName).delete().eq('id', tableId);
  }

//STATUS UPDATE
  Future<void> updateStatus(
      {required int tableId, required String status}) async {
    await _client.from('tables').update({'status': status}).eq('id', tableId);
  }
}
