import 'package:timerflow/data/services/supabase/database/food_report_service.dart';
import 'package:timerflow/domain/models/food_report_model.dart';

class FoodReportRepository {
  final FoodReportService service;
  FoodReportRepository({required this.service});

  Future<void> bulkInsertBySessionId({required int sessionId,required int sessionReportId}) async =>
      await service.bulkInsertBySessionId(
          sessionId: sessionId, sessionReportId: sessionReportId);

  Future<List<FoodReportModel>> getFoodReportsByUserReportId() async =>
      await service.getFoodReportsByUserId();
}
