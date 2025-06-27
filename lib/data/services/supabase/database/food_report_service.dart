import 'package:timerflow/domain/models/food_report_model.dart';
import 'package:timerflow/exports.dart';

class FoodReportService {
  final supabase = Supabase.instance.client;
  final String tableName = 'food_report';


  Future<List<FoodReportModel>> getFoodReportsByUserId() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final response = await supabase
          .from(tableName)
          .select('*, food(*)')
          .eq('user_id', userId);

      return (response as List)
          .map((e) => FoodReportModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint('❌ Error fetching food reports by user: $e');
      rethrow;
    }
  }


  Future<void> bulkInsertBySessionId({required int sessionId,required int sessionReportId}) async {
    try {
      final authData = getUserIdAndTimestamp();

      final orders = await supabase
          .from('order_foods')
          .select()
          .eq('session_id', sessionId);

      final List<Map<String, dynamic>> reportData = (orders as List).map((order) {
        return {
          'food_id': order['food_id'],
          'quantity': order['quantity'],
          'session_report_id': sessionReportId,
          ...authData,
        };
      }).toList();

      if (reportData.isNotEmpty) {
        await supabase.from(tableName).insert(reportData);
        debugPrint('✅ Bulk food reports inserted for session $sessionId');
      } else {
        debugPrint('ℹ️ No food orders found for session $sessionId');
      }
    } catch (e) {
      debugPrint('❌ Error inserting food reports: $e');
      rethrow;
    }
  }
}
