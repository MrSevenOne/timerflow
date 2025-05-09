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

  Future<void> fetchAll() async {
    _setLoading(true);
    try {
      _reports = await _repository.getAllFoodReport();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _reports = [];
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addReport(FoodReportModel model) async {
    _setLoading(true);
    try {
      await _repository.addFoodReport(foodReport: model);
      await fetchAll(); // Refresh after add
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteReport(int id) async {
    _setLoading(true);
    try {
      await _repository.deleteFoodReport(id: id);
      await fetchAll(); // Refresh after delete
      _error = null;
    } catch (e) {
      _error = e.toString();
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
         sessionId,
        sessionReportId,
      );
      await fetchAll(); // Optional refresh
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
