import 'package:flutter/material.dart';

/// BaseViewModel barcha ViewModel’lar uchun umumiy
/// - loading holatini boshqaradi
/// - error va success xabarlarni UI ga uzatadi
class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  /// Loading holatini sozlash
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Error xabarni sozlash
  void setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  /// Success xabarni sozlash
  void setSuccess(String? message) {
    _successMessage = message;
    notifyListeners();
  }

  /// Error va success xabarlarni tozalash
  void clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  /// Async action wrapper
  /// - Loading boshqaradi
  /// - Xatoni catch qiladi
  Future<void> runFuture(Future<void> Function() action) async {
    setLoading(true);
    clearMessages();
    try {
      await action();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }
}
