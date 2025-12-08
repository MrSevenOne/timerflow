import 'package:flutter/material.dart';
import 'package:timerflow/models/user_model.dart';
import 'package:timerflow/services/remote/auth/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _service = AuthService();

  bool isLoading = false;
  String? errorMessage;
  UserModel? currentUser;

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  // REGISTER
  Future<bool> register(UserModel model) async {
    try {
      _setLoading(true);
      final result = await _service.register(model);

      if (result != null) {
        currentUser = result;
        notifyListeners();
        return true;
      } else {
        errorMessage = "Registration failed";
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    return false;
  }

  // LOGIN
  Future<bool> login(String email, String password) async {
    try {
      _setLoading(true);

      final ok = await _service.login(email, password);
      if (!ok) {
        errorMessage = "Login failed";
        return false;
      }

      // login bo'lgach userni DBdan olish
      // lekin sizda login paytida "users" tablega query qilishni
      // xohlasangiz shuni ham qo'shib beraman.

      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // LOGOUT
  Future<void> logout() async {
    await _service.logout();
    currentUser = null;
    notifyListeners();
  }
}
