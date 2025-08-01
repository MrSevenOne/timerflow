import 'package:timerflow/exports.dart';

class PaymentReportService extends BaseService {
  PaymentReportService() : super('payments');

  /// Barcha to‘lov hisobotlarini olish
  Future<List<PaymentModel>> getPayments() async {
    checkUserId();

    try {
      final response = await supabase
          .from(tableName)
          .select()
          .eq('user_id', currentUserId!)
          .order('payment_time', ascending: false);

      return (response as List)
          .map((e) => PaymentModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint("getPayments error: $e");
      throw Exception("To‘lovlar yuklanmadi: $e");
    }
  }

  /// Foydalanuvchi va sessiya bo‘yicha olish (ixtiyoriy)
  Future<List<PaymentModel>> getPaymentsBySession(String sessionId) async {
    checkUserId();

    try {
      final response = await supabase
          .from(tableName)
          .select()
          .eq('user_id', currentUserId!)
          .eq('session_id', sessionId)
          .order('payment_time', ascending: false);

      return (response as List)
          .map((e) => PaymentModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint("getPaymentsBySession error: $e");
      throw Exception("To‘lovlar yuklanmadi: $e");
    }
  }
}
