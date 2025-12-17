import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/models/table/table_model.dart';

class TableSupabaseService {
  final SupabaseClient _client = Supabase.instance.client;
  static const String _tableName = 'tables';

  Future<List<TableModel>> fetchAll(String? userId) async {
    try {
      PostgrestFilterBuilder query = _client.from(_tableName).select('*');
      if (userId != null) query = query.eq('user_id', userId);

      final List data = await query.order('updated_at', ascending: true);

      return data.map((e) => TableModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Fetch tables failed: $e');
    }
  }

  Future<TableModel> upsertTable(TableModel table) async {
    try {
      final data = await _client
          .from(_tableName)
          .upsert(table.toJson(), onConflict: 'id')
          .select()
          .single();

      return TableModel.fromJson(data);
    } catch (e) {
      throw Exception('Upsert table failed: $e');
    }
  }
}
