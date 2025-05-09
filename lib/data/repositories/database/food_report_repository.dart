import 'package:timerflow/data/services/supabase/database/food_report_service.dart';
import 'package:timerflow/domain/models/food_report_model.dart';

class FoodReportRepository {
  final FoodReportService service;
  FoodReportRepository({required this.service});

  Future<List<FoodReportModel>> getAllFoodReport() async =>
      await service.getAllFoodReports();
  Future<void> addFoodReport({required FoodReportModel foodReport}) async =>
      await service.addFoodReport(foodReport);

  Future<void> deleteFoodReport({required int id}) async =>
      await service.deleteFoodReport(id);
  Future<void> bulkInsertBySessionId(int sessionId,sessionReportId) async =>
      await service.bulkInsertBySessionId(sessionId, sessionReportId);
}
