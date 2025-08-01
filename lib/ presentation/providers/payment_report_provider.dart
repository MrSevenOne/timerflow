import 'package:flutter/material.dart';
import 'package:timerflow/data/services/supabase/database/payment_report_service.dart';
import 'package:timerflow/domain/models/payment_model.dart';

enum ReportFilter { daily, weekly, monthly }

class PaymentReportViewModel extends ChangeNotifier {
  final PaymentReportService _service = PaymentReportService();

  List<PaymentModel> _allPayments = [];
  List<PaymentModel> _filteredPayments = [];
  bool _isLoading = false;
  String? _error;
  ReportFilter _filter = ReportFilter.daily;

  List<PaymentModel> get payments => _filteredPayments;
  bool get isLoading => _isLoading;
  String? get error => _error;
  ReportFilter get filter => _filter;

  Future<void> fetchPayments() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allPayments = await _service.getPayments();
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

    _filteredPayments = _allPayments.where((p) => p.paymentTime!.isAfter(start)).toList();
    notifyListeners();
  }

int get totalAmount {
  return _filteredPayments.fold(0.0, (sum, p) => sum + (p.totalAmount ?? 0)).toInt();
}

}