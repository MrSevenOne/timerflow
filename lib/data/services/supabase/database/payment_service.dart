import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/domain/models/payment_model.dart';

class PaymentService {
  final supabase = Supabase.instance.client;
  final tableName = 'payment_report';
  final userId = Supabase.instance.client.auth.currentUser?.id;


  // Barcha paymentlarni olish
  Future<List<PaymentReportModel>> getAllPayments() async {
    try {
      final response = await supabase.from(tableName).select('*,tables(*)');

      debugPrint('Payments fetched: $response');
      return (response as List<dynamic>)
          .map((e) => PaymentReportModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint('Error fetching payments: $e');
      rethrow;
    }
  }

  // Login bo‘lgan userga tegishli paymentlarni olish
Future<List<PaymentReportModel>> getPaymentsByUser() async {
  try {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not logged in');

    final response = await supabase
        .from(tableName)
        .select('*,tables(*)')
        .eq('user_id', userId);

    debugPrint('Payments for user $userId fetched: $response');
    return (response as List<dynamic>)
        .map((e) => PaymentReportModel.fromJson(e))
        .toList();
  } catch (e) {
    debugPrint('Error fetching payments for user: $e');
    rethrow;
  }
}


  // ID bo'yicha bitta paymentni olish
  Future<PaymentReportModel?> getPaymentById(int id) async {
    try {
      final response = await supabase
          .from(tableName)
          .select()
          .eq('id', id)
          .maybeSingle();

      debugPrint('Payment fetched by id: $response');
      if (response == null) return null;
      return PaymentReportModel.fromJson(response);
    } catch (e) {
      debugPrint('Error fetching payment by id: $e');
      return null;
    }
  }

  // Yangi payment qo‘shish yoki mavjudini yangilash (session_id bo‘yicha)
Future<void> addOrUpdatePayment(PaymentReportModel paymentModel) async {
  try {
    await supabase.from(tableName)
        .upsert(paymentModel.toJson(), onConflict: 'session_report_id');

    debugPrint('Payment added or updated successfully');
  } catch (e) {
    debugPrint('Error adding or updating payment: $e');
    rethrow;
  }
}



  // Paymentni o'chirish
  Future<void> deletePayment(int id) async {
    try {
      await supabase.from(tableName).delete().eq('id', id);

      debugPrint('Payment deleted successfully: $id');
    } catch (e) {
      debugPrint('Error deleting payment: $e');
      rethrow;
    }
  }
}
