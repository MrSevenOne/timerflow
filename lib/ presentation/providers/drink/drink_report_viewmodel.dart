import 'package:flutter/foundation.dart';
import 'package:timerflow/data/repositories/database/drink_report_repository.dart';
import 'package:timerflow/domain/models/drink_report_model.dart';

class DrinkReportViewModel extends ChangeNotifier {
  final DrinkReportRepository _repository;

  List<DrinkReportModel> _reports = [];
  bool _isLoading = false;
  String? _error;

  DrinkReportViewModel(this._repository);

  List<DrinkReportModel> get reports => _reports;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchByUserId() async {
    _setLoading(true);
    try {
      _reports = await _repository.getByUserIdAll();
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
        sessionId: sessionId,
        sessionReportId: sessionReportId,
      );
      await fetchByUserId(); // Optional: refresh list if needed
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
