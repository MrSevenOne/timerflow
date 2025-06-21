import 'package:timerflow/data/services/supabase/database/table_report_service.dart';
import 'package:timerflow/domain/models/session_report_model.dart';

class SessionReportRepository {
  final SessionReportService _service;

  SessionReportRepository(this._service);
// Get All Report
  Future<List<SessionReportModel>> getAllReports() async =>
      await _service.getAllSessionReports();
//Get by Table ID
  Future<List<SessionReportModel>> getReportByTableId(int tableId) async =>
      await _service.getSessionReportsByTableId(tableId);

// Add Session Report
  Future<void> addReport({required SessionReportModel model}) async =>
      await _service.addSessionReport(model);

// Get session By Table Id
  Future getSessionReportBySessionId({required int sessionId}) async =>
      _service.getSessionReportBySessionId(sessionId);

// Delete Session Report
  Future<void> deleteReport({required int id}) async =>
      await _service.deleteSessionReport(id);
}
