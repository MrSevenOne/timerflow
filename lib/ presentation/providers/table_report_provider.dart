import 'package:flutter/material.dart';
import 'package:timerflow/data/services/supabase/database/table_report_service.dart';
import 'package:timerflow/domain/models/table_report_model.dart';

enum ReportFilter { daily, weekly, monthly }

class TableReportViewModel with ChangeNotifier {
  final TableReportService _reportService;

  TableReportViewModel(this._reportService);

  List<TableReportModel> _allReports = [];
  List<TableReportModel> _filteredReports = [];
  bool _isLoading = false;
  String? _error;
  ReportFilter _filter = ReportFilter.daily;

  List<TableReportModel> get reports => _filteredReports;
  bool get isLoading => _isLoading;
  String? get error => _error;
  ReportFilter get filter => _filter;

  Future<void> fetchReports() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _allReports = await _reportService.getTableReports();
      applyFilter(_filter);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void applyFilter(ReportFilter filter) {
    _filter = filter;
    final now = DateTime.now();
    DateTime start;

    switch (filter) {
      case ReportFilter.daily:
        start = DateTime(now.year, now.month, now.day);
        break;
      case ReportFilter.weekly:
        start = now.subtract(Duration(days: now.weekday - 1));
        break;
      case ReportFilter.monthly:
        start = DateTime(now.year, now.month);
        break;
    }

    _filteredReports = _allReports.where((r) => r.startDate.isAfter(start)).toList();
    notifyListeners();
  }

  Future<void> fetchReportsByTable(String tableId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _allReports = await _reportService.getReportsByTableId(tableId);
      applyFilter(_filter);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<TableReportModel> addReport(TableReportModel report) async {
    _isLoading = true;
    notifyListeners();

    try {
      final newReport = await _reportService.addReport(report);
      _allReports.insert(0, newReport);
      applyFilter(_filter);
      _error = null;
      return newReport;
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteReport(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _reportService.deleteReport(id);
      _allReports.removeWhere((report) => report.id == id);
      applyFilter(_filter);
      _error = null;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  double get totalRevenue {
    return _filteredReports.fold(0.0, (sum, r) => sum + (r.tableRevenue ?? 0));
  }
}
