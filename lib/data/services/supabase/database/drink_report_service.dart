
import '../../../../exports.dart';

class DrinkReportService {
  final supabase = Supabase.instance.client;
  final String tableName = 'drink_report';

  Future<List<DrinkReportModel>> getDrinkReportsByUserId() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final response = await supabase
          .from(tableName)
          .select('*, drink(*)')
          .eq('user_id', userId);

      return (response as List)
          .map((e) => DrinkReportModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint('Error fetching drink reports: $e');
      rethrow;
    }
  }

  Future<void> bulkInsertBySessionId(int sessionId, int sessionReportId) async {
    try {
      final authData = getUserIdAndTimestamp();

      final orders = await supabase
          .from('order_drinks')
          .select()
          .eq('session_id', sessionId);

      final List<Map<String, dynamic>> reportData = (orders as List).map((order) {
        return {
          'drink_id': order['drink_id'],
          'quantity': order['quantity'],
          'session_report_id': sessionReportId,
          ...authData,
        };
      }).toList();

      if (reportData.isNotEmpty) {
        await supabase.from(tableName).insert(reportData);
        debugPrint('✅ Bulk drink reports inserted for session $sessionId');
      } else {
        debugPrint('ℹ️ No drink orders found for session $sessionId');
      }
    } catch (e) {
      debugPrint('❌ Error inserting drink reports: $e');
      rethrow;
    }
  }
}
