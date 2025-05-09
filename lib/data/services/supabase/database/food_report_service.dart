import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/domain/models/food_report_model.dart';

class FoodReportService {
  final supabase = Supabase.instance.client;
  final String tableName = 'food_report';

  Future<List<FoodReportModel>> getAllFoodReports() async {
    try {
      final response = await supabase.from(tableName).select('*');
      return (response as List).map((e) => FoodReportModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Error fetching food reports: $e');
      rethrow;
    }
  }

  Future<void> addFoodReport(FoodReportModel report) async {
    try {
      await supabase.from(tableName).insert(report.toJson());
      debugPrint('Food report added successfully');
    } catch (e) {
      debugPrint('Error adding food report: $e');
      rethrow;
    }
  }

  Future<void> bulkInsertBySessionId(int sessionId, int sessionReportId) async {
  try {
    final orders = await supabase
        .from('order_foods')
        .select()
        .eq('session_id', sessionId);

    final List<Map<String, dynamic>> reportData = (orders as List).map((order) {
      return {
        'food_id': order['food_id'],
        'quantity': order['quantity'],
        'session_report_id': sessionReportId,
      };
    }).toList();

    if (reportData.isNotEmpty) {
      await supabase.from(tableName).insert(reportData);
      debugPrint('Bulk food reports inserted for session $sessionId');
    } else {
      debugPrint('No order_food records found for session $sessionId');
    }
  } catch (e) {
    debugPrint('Error in bulk insert to food_report: $e');
    rethrow;
  }
}


  Future<void> deleteFoodReport(int id) async {
    try {
      await supabase.from(tableName).delete().eq('id', id);
      debugPrint('Food report deleted: $id');
    } catch (e) {
      debugPrint('Error deleting food report: $e');
      rethrow;
    }
  }
}
