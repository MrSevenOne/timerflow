import 'package:timerflow/exports.dart';

class PaymentViewModel extends ChangeNotifier {
  final PaymentService _paymentService;

  PaymentViewModel(this._paymentService);

  PaymentModel? _payment;
  bool _isLoading = false;
  String? _error;

  PaymentModel? get payment => _payment;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // ✅ To'lovni session ID bo'yicha yuklash
  Future<void> fetchPaymentBySession(String sessionId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _payment = await _paymentService.getPaymentBySession(sessionId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ✅ Yangi to'lov qo'shish
  Future<void> addPayment(PaymentModel payment) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _paymentService.addPayment(payment);
      _payment = payment;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ✅ Reset qilish
  void clear() {
    _payment = null;
    _error = null;
    _isLoading = false;
    notifyListeners();
  }
}
