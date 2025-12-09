// lib/services/remote/table_supabase_service.dart

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/models/table_model.dart';

class TableSupabaseService {
  final _client = Supabase.instance.client;
  final String tableName = 'tables';

  /// Fetch ALL tables (optionally for a specific user)
  Future<List<TableModel>> fetchAll({String? userId}) async {
    final query = _client.from(tableName).select();
    if (userId != null) {
      query.eq('user_id', userId);
    }
    final res = await query.order('id', ascending: true);
    if (res is List) {
      return res.map((e) => TableModel.fromMap(e as Map<String, dynamic>)).toList();
    }
    return [];
  }

  /// Fetch changes since lastSync (server-side updated_at >= lastSync)
  Future<List<TableModel>> fetchChanges(DateTime lastSync, {String? userId}) async {
    final iso = lastSync.toUtc().toIso8601String();
    var query = _client.from(tableName).select().gte('updated_at', iso);
    if (userId != null) query = query.eq('user_id', userId);
    final res = await query.order('updated_at', ascending: true);
    if (res is List) {
      return res.map((e) => TableModel.fromMap(e as Map<String, dynamic>)).toList();
    }
    return [];
  }

  /// Insert table -> returns server TableModel (with id, created_at, updated_at)
  Future<TableModel> insertTable(TableModel table) async {
    final payload = table.toMapForServer();
    final response = await _client.from(tableName).insert(payload).select().single();
    return TableModel.fromMap(response as Map<String, dynamic>);
  }

  /// Update table by id
  Future<TableModel> updateTable(int id, TableModel table) async {
    final payload = table.toMapForServer();
    final response = await _client.from(tableName).update(payload).eq('id', id).select().single();
    return TableModel.fromMap(response as Map<String, dynamic>);
  }

  /// Delete table by id
  Future<void> deleteTable(int id) async {
    await _client.from(tableName).delete().eq('id', id);
  }
}
