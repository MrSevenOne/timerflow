import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/domain/models/session_report_model.dart';

class SessionReportService {
  final supabase = Supabase.instance.client;
  final String tableName = 'session_report';

  /// 🔽 Get All Session Reports
  Future<List<SessionReportModel>> getAllSessionReports() async {
    try {
      final response = await supabase.from(tableName).select('*, tables(*)');
      return (response as List)
          .map((e) => SessionReportModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint('Error fetching session reports: $e');
      rethrow;
    }
  }

  /// 🔽 Get Session Reports by Authenticated User
  Future<List<SessionReportModel>> getSessionReportsByUserId() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final response = await supabase
          .from(tableName)
          .select('*, tables(*)')
          .eq('user_id', userId);

      return (response as List)
          .map((e) => SessionReportModel.fromJson(e))
          .toList();
    } catch (error) {
      debugPrint('Error fetching session reports by user ID: $error');
      rethrow;
    }
  }

  /// 🔽 Get All Session Reports by Table ID
  Future<List<SessionReportModel>> getSessionReportsByTableId(int tableId) async {
    try {
      final response = await supabase
          .from(tableName)
          .select('*, tables(*)')
          .eq('table_id', tableId);

      return (response as List)
          .map((e) => SessionReportModel.fromJson(e))
          .toList();
    } catch (error) {
      debugPrint('Error fetching session reports by table ID: $error');
      rethrow;
    }
  }

  /// ➕ Add or Update Session Report
 Future<int> addReport(SessionReportModel model) async {
  try {
    final response = await supabase
        .from('session_report')
        .insert(model.toJson())
        .select()
        .single(); // bu qo‘shilgan rowni qaytaradi

    final insertedId = response['id'] as int;
    debugPrint("✅ Session report inserted with ID: $insertedId");
    return insertedId;
  } catch (e) {
    debugPrint("❌ Error inserting session report: $e");
    rethrow;
  }
}


  /// 🗑 Delete Session Report
  Future<void> deleteSessionReport(int id) async {
    try {
      await supabase.from(tableName).delete().eq('id', id);
      debugPrint('Session report deleted: $id');
    } catch (e) {
      debugPrint('Error deleting session report: $e');
      rethrow;
    }
  }
}
