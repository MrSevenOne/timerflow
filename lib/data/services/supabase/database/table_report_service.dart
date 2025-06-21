import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/domain/models/session_report_model.dart';

class SessionReportService {
  final supabase = Supabase.instance.client;
  final String tableName = 'session_report';

  ///Get All Session Report
  Future<List<SessionReportModel>> getAllSessionReports() async {
    try {
      final response = await supabase.from(tableName).select('*,tables(*)');
      return (response as List)
          .map((e) => SessionReportModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint('Error fetching session reports: $e');
      rethrow;
    }
  }

  /// Get Session Report by Session ID
 Future<SessionReportModel?> getSessionReportBySessionId(int sessionId) async {
  try {
    final response = await supabase
        .from(tableName)
        .select('*,tables(*)')
        .eq('session_id', sessionId)
        .limit(1)
        .single(); // gets exactly one result, or throws

    return SessionReportModel.fromJson(response);
  } catch (error) {
    debugPrint('Error fetching getSessionReportBySessionId: $error');
    return null;
  }
}
/// Get All Session Reports by Table ID
Future<List<SessionReportModel>> getSessionReportsByTableId(int tableId) async {
  try {
    final response = await supabase
        .from(tableName)
        .select('*,tables(*)')
        .eq('table_id', tableId);

    return (response as List)
        .map((e) => SessionReportModel.fromJson(e))
        .toList();
  } catch (error) {
    debugPrint('Error fetching session reports by table ID: $error');
    rethrow;
  }
}



  ///Add Session Report
 /// Add or Update Session Report by session_id
Future<void> addSessionReport(SessionReportModel report) async {
  try {
    await supabase.from(tableName)
        .upsert(report.toJson(), onConflict: 'session_id');
    debugPrint('Session report added or updated successfully');
  } catch (e) {
    debugPrint('Error adding or updating session report: $e');
    rethrow;
  }
}


  /// Delete Session Report
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
