import 'package:flutter/material.dart';
import 'package:timerflow/data/services/supabase/database/payment_service.dart';
import 'package:timerflow/domain/models/payment_model.dart';

class CheckoutViewModel extends ChangeNotifier {
  final PaymentService _paymentService;

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  CheckoutViewModel(this._paymentService);

  Future<bool> checkoutAll({
    required PaymentReportModel payment,
    required Future<void> Function() insertDrinkReports,
    required Future<void> Function() insertFoodReports,
    required Future<void> Function() deleteSession,
    required Future<void> Function() freeTable,
  }) async {
    _setLoading(true);
    try {
      await _paymentService.addOrUpdatePayment(payment);
      await insertDrinkReports();
      await insertFoodReports();
      await deleteSession();
      await freeTable();

      _error = null;
      return true;
    } catch (e) {
      _error = e.toString();
      debugPrint("Checkout Error: $_error");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }
}
