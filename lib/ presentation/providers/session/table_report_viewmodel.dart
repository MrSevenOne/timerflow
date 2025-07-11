import 'package:flutter/material.dart';
import 'package:timerflow/data/repositories/database/table_report_repository.dart';
import 'package:timerflow/domain/models/session_report_model.dart';

class SessionReportViewModel extends ChangeNotifier {
  final SessionReportRepository _repository;

  SessionReportViewModel(this._repository);

  // ignore: non_constant_identifier_names
  List<SessionReportModel> _session_reports = [];
  SessionReportModel? _sessionbyId;
  List<SessionReportModel> _sessionByTableId = [];
  bool _isLoading = false;
  String? _error;

  List<SessionReportModel> get sessionReports => _session_reports;
  SessionReportModel? get sessionbyId => _sessionbyId;
  List<SessionReportModel> get sessionByTableId => _sessionByTableId;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchAllReports() async {
    _setLoading(true);
    try {
      _session_reports = await _repository.getAllReports();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _session_reports = [];
    } finally {
      _setLoading(false);
    }
  }


Future<int?> addReport(SessionReportModel model) async {
  _setLoading(true);
  try {
    final id = await _repository.addReport(model: model);
    await fetchAllReports();
    return id;
  } catch (e) {
    _error = e.toString();
    return null;
  } finally {
    _setLoading(false);
  }
}


  Future<SessionReportModel?> getSessionReportByUserId() async {
    _setLoading(true);
    try {
      _session_reports =
          await _repository.getSessionReportByUserId();
      _error = null;
      return _sessionbyId;
    } catch (e) {
      _error = e.toString();
      return null;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteReport(int id) async {
    _setLoading(true);
    try {
      await _repository.deleteReport(id: id);
      _session_reports.removeWhere((report) => report.id == id);
      notifyListeners();
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
