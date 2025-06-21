import 'package:flutter/material.dart';
import 'package:timerflow/data/repositories/database/payment_repository.dart';
import 'package:timerflow/domain/models/payment_model.dart';

class PaymentViewModel extends ChangeNotifier {
  final PaymentRepository _paymentRepository;

  PaymentReportModel? _payment;
  List<PaymentReportModel> _payments = [];
  bool _isLoading = false;
  String? _error;

  PaymentViewModel(this._paymentRepository);

  PaymentReportModel? get payment => _payment;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<PaymentReportModel> get payments => _payments;

  // Public method to set loading from outside
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Get payment
  Future<void> fetchPayments() async {
    setLoading(true);
    try {
      _payments = await _paymentRepository.getAllPayments();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  // Fetch payment by ID
  Future<void> fetchPaymentById(int id) async {
    setLoading(true);
    try {
      _payment = await _paymentRepository.getPaymentById(id: id);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _payment = null;
    } finally {
      setLoading(false);
    }
  }

  // Add or update payment
  Future<bool> addPayment(PaymentReportModel model) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _paymentRepository.addOrUpdatePayment(paymentModel: model);

      return true; // ✅ muvaffaqiyatli bo‘lsa true qaytaradi
    } catch (e) {
      debugPrint('Error adding payment: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete payment by ID
  Future<void> deletePayment(int id) async {
    setLoading(true);
    try {
      await _paymentRepository.deletePayment(id: id);
      _payment = null;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }
}
