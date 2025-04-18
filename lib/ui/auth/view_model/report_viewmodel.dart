import 'package:flutter/material.dart';
import 'package:timerflow/data/services/supabase/database/report_services.dart';
import 'package:timerflow/domain/models/report_model.dart';

class ReportViewmodel extends ChangeNotifier {
  final SessionHistoryService _service = SessionHistoryService();

  List<ReportModel> _allHistory = [];
  List<ReportModel> get allHistory => _allHistory;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Hammasini yuklab olish
  Future<void> fetchAllHistory() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allHistory = await _service.getAllHistory();
    } catch (e) {
      debugPrint("Error fetching history: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Sana oralig'ida filtrlangan sessiyalarni olish
  Future<List<ReportModel>> fetchByDateRange(DateTime start, DateTime end) async {
    _isLoading = true;
    notifyListeners();

    List<ReportModel> result = [];

    try {
      result = await _service.getByDateRange(start, end);
    } catch (e) {
      debugPrint("Error filtering history: $e");
    }

    _isLoading = false;
    notifyListeners();
    return result;
  }

  /// Mahalliy filtering (oldindan yuklab olingan ma'lumotdan)
  List<ReportModel> filterLocalByDateRange(DateTime start, DateTime end) {
    return _allHistory.where((item) {
      return item.endTime.isAfter(start) && item.endTime.isBefore(end);
    }).toList();
  }

  /// Jami daromad hisoblash
  double getTotalRevenue({DateTime? start, DateTime? end}) {
    final filtered = (start != null && end != null)
        ? filterLocalByDateRange(start, end)
        : _allHistory;

    return filtered.fold(0, (sum, item) => sum + (item.totalAmount ?? 0));
  }
}
