import 'package:timerflow/data/services/supabase/database/drink_report_service.dart';
import 'package:timerflow/domain/models/drink_report_model.dart';

class DrinkReportRepository {
  final DrinkReportService service;
  DrinkReportRepository(this.service);

  Future<List<DrinkReportModel>> getAll() => service.getAllDrinkReports();
  Future<void> add(DrinkReportModel model) => service.addDrinkReport(model);
  Future<void> delete(int id) => service.deleteDrinkReport(id);

  Future<void> bulkInsertBySessionId(
      {required int sessionId, required int sessionReportId}) async {
    await service.bulkInsertBySessionId(sessionId, sessionReportId);
  }
}
