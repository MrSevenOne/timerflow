import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/domain/models/drink_report_model.dart';

class DrinkReportService {
  final supabase = Supabase.instance.client;
  final String tableName = 'drink_report';

  Future<List<DrinkReportModel>> getAllDrinkReports() async {
    try {
      final response = await supabase.from(tableName).select('*, drink(*)');
      return (response as List).map((e) => DrinkReportModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Error fetching drink reports: $e');
      rethrow;
    }
  }

  Future<void> addDrinkReport(DrinkReportModel report) async {
    try {
      await supabase.from(tableName).insert(report.toJson());
      debugPrint('Drink report added successfully');
    } catch (e) {
      debugPrint('Error adding drink report: $e');
      rethrow;
    }
  }

  Future<void> deleteDrinkReport(int id) async {
    try {
      await supabase.from(tableName).delete().eq('id', id);
      debugPrint('Drink report deleted: $id');
    } catch (e) {
      debugPrint('Error deleting drink report: $e');
      rethrow;
    }
  }

  /// 🔁 Bulk insert all order_drink items by session ID into drink_report
  Future<void> bulkInsertBySessionId(int sessionId, int sessionReportId) async {
    try {
      final orders = await supabase
          .from('order_drinks')
          .select()
          .eq('session_id', sessionId);

      final List<Map<String, dynamic>> reportData = (orders as List).map((order) {
        return {
          'drink_id': order['drink_id'],
          'quantity': order['quantity'],
          'session_report_id': sessionReportId,
        };
      }).toList();

      if (reportData.isNotEmpty) {
        await supabase.from(tableName).insert(reportData);
        debugPrint('Bulk drink reports inserted for session $sessionId');
      } else {
        debugPrint('No order_drink records found for session $sessionId');
      }
    } catch (e) {
      debugPrint('Error in bulk insert to drink_report: $e');
      rethrow;
    }
  }
}
