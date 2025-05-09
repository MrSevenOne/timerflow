import 'package:timerflow/data/services/supabase/database/payment_service.dart';
import 'package:timerflow/domain/models/payment_model.dart';

class PaymentRepository {
  final PaymentService service;
  PaymentRepository(this.service);

  // Barcha to'lovlarni olish
  Future<List<PaymentReportModel>> getAllPayments() => service.getAllPayments();

  // ID bo'yicha to'lovni olish
  Future<PaymentReportModel?> getPaymentById({required int id}) =>
      service.getPaymentById(id);

  // Yangi to'lov qo'shish
  Future<void> addOrUpdatePayment({required PaymentReportModel paymentModel}) =>
      service.addOrUpdatePayment(paymentModel);

  // To'lovni o'chirish
  Future<void> deletePayment({required int id}) => service.deletePayment(id);
}
