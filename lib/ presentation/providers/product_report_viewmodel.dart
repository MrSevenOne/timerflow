import 'package:flutter/material.dart';
import 'package:timerflow/data/services/supabase/database/product_report_service.dart';
import 'package:timerflow/domain/models/product_report_model.dart';

enum ReportFilter { daily, weekly, monthly }

class ProductReportViewModel extends ChangeNotifier {
  final ProductReportService _service = ProductReportService();

  List<ProductReportModel> _allReports = [];
  List<ProductReportModel> _filteredReports = [];
  bool _isLoading = false;
  String? _error;
  ReportFilter _filter = ReportFilter.daily;

  List<ProductReportModel> get reports => _filteredReports;
  bool get isLoading => _isLoading;
  String? get error => _error;
  ReportFilter get filter => _filter;

  Future<void> fetchReports() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allReports = await _service.getAllProductReports();
      applyFilter(_filter);
      _error = null;
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

    _filteredReports = _allReports.where((r) => r.createdAt.isAfter(start)).toList();
    notifyListeners();
  }

  int get totalAmount {
    return _filteredReports.fold(0, (sum, report) {
      final price = report.product?.price ?? 0;
      return sum + (price * report.quantity);
    });
  }

  /// 🟢 Faqat tableId bo‘yicha ordersni product_reportsga ko‘chirish
  Future<void> moveOrdersByTableId(String tableId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _service.moveOrdersByTableId(tableId: tableId);
      await fetchReports(); // yangilab olish
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}