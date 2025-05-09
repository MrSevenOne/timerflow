import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/data/repositories/database/auth/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository);


  final _supabase = Supabase.instance.client;
  Stream<AuthState> get authState => _supabase.auth.onAuthStateChange;


  bool _isLoading = false;
  String? _error;
  User? _user;

  bool get isLoading => _isLoading;
  String? get error => _error;
  User? get user => _user;

  Future<void> signIn(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _authRepository.signIn(email, password);
      _user = response.user;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _authRepository.signUp(email, password);
      _user = response.user;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authRepository.signOut();
      _user = null;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void loadCurrentUser() {
    _user = _authRepository.getCurrentUser();
    notifyListeners();
  }
}
