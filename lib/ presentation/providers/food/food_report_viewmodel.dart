import 'package:flutter/foundation.dart';
import 'package:timerflow/data/repositories/database/food_report_repository.dart';
import 'package:timerflow/domain/models/food_report_model.dart';

class FoodReportViewModel extends ChangeNotifier {
  final FoodReportRepository _repository;

  List<FoodReportModel> _reports = [];
  bool _isLoading = false;
  String? _error;

  FoodReportViewModel(this._repository);

  List<FoodReportModel> get reports => _reports;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchByUserReportId() async {
    _setLoading(true);
    try {
      _reports = await _repository.getFoodReportsByUserReportId();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _reports = [];
    } finally {
      _setLoading(false);
    }
  }

  Future<void> insertBulkBySession({
    required int sessionId,
    required int sessionReportId,
  }) async {
    _setLoading(true);
    try {
      await _repository.bulkInsertBySessionId(
          sessionId: sessionId, sessionReportId: sessionReportId);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
