import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/domain/models/report_model.dart';

class SessionHistoryService {
  final SupabaseClient client = Supabase.instance.client;
  final String tableName = 'session_history';

  Future<void> addToHistory(ReportModel session) async {
    try {
      await client.from(tableName).insert(session.toJson());
    } catch (e) {
      throw Exception("Failed to insert into history: $e");
    }
  }

  Future<List<ReportModel>> getAllHistory() async {
    try {
      final response = await client.from(tableName).select();
      final data = List<Map<String, dynamic>>.from(response);
      return data.map((e) => ReportModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to fetch session history: $e");
    }
  }

  Future<List<ReportModel>> getByDateRange(DateTime start, DateTime end) async {
    try {
      final response = await client
          .from(tableName)
          .select()
          .gte('end_time', start.toIso8601String())
          .lte('end_time', end.toIso8601String());

      final data = List<Map<String, dynamic>>.from(response);
      return data.map((e) => ReportModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to fetch filtered history: $e");
    }
  }
}
