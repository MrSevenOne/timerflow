
import 'package:timerflow/exports.dart';

class PaymentService extends BaseService {
  PaymentService() : super('payments');

  Future<PaymentModel> getPaymentBySession(String sessionId) async {
    checkUserId();
    
    try {
      final response = await supabase
          .from(tableName)
          .select()
          .eq('session_id', sessionId)
          .eq('user_id', currentUserId!)
          .single();
      
      return PaymentModel.fromJson(response);
    } catch (e) {
      throw Exception('To\'lov ma\'lumotlari yuklanmadi: $e');
    }
  }

  Future<void> addPayment(PaymentModel payment) async {
    checkUserId();
    
    try {
      await supabase
          .from(tableName)
          .insert(payment.copyWith(userId: currentUserId).toJson());
    } catch (e) {
      throw Exception('To\'lov qo\'shilmadi: $e');
    }
  }
}