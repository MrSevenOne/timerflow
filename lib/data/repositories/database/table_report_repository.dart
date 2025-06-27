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
Future<int> addReport({required SessionReportModel model}) {
  return _service.addReport(model);
}


// Get session By Table Id
  Future getSessionReportByUserId() async =>
      _service.getSessionReportsByUserId();

// Delete Session Report
  Future<void> deleteReport({required int id}) async =>
      await _service.deleteSessionReport(id);
}
