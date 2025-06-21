import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/data/repositories/database/auth/auth_repository.dart';
import 'package:timerflow/routers/app_routers.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository) {
    loadCurrentUser();
  }

  final _supabase = Supabase.instance.client;
   get authState => _supabase.auth.onAuthStateChange;

  bool _isLoading = false;
  String? _error;
  User? _user;

  bool get isLoading => _isLoading;
  String? get error => _error;
  User? get user => _user;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _error = value;
    notifyListeners();
  }

  void _setUser(User? value) {
    _user = value;
    notifyListeners();
  }

  /// SIGN IN
  Future<void> signIn(String email, String password) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _authRepository.signIn(email, password);
      _setUser(response?.user);
    } catch (e) {
      _setError("error_login".tr);
      debugPrint("SignIn Error: $e");
    }

    _setLoading(false);
  }

  /// SIGN UP
  Future<void> signUp(String email, String password) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _authRepository.signUp(email, password);
      if (response?.user == null) {
        _setError("Email already registered or confirmation required.");
      } else {
        _setUser(response?.user);
      }
    } catch (e) {
      _setError("error_signup".tr);
      debugPrint("SignUp Error: $e");
    }

    _setLoading(false);
  }

  /// SIGN OUT
  Future<void> signOut(BuildContext context) async {
  _setLoading(true);
  try {
    await _authRepository.signOut();
    _setUser(null);

    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
    }
  } catch (e) {
    _setError("Sign out failed: $e");
  }
  _setLoading(false);
}


  /// LOAD CURRENT USER (on app start)
  void loadCurrentUser() {
    _setUser(_authRepository.getCurrentUser());
  }
}
