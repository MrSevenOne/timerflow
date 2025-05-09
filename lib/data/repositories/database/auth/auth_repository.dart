import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/data/services/supabase/database/auth/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Future<AuthResponse> signIn(String email, String password) {
    return _authService.signIn(email, password);
  }

  Future<AuthResponse> signUp(String email, String password) {
    return _authService.signUp(email, password);
  }

  Future<void> signOut() {
    return _authService.signOut();
  }

  User? getCurrentUser() {
    return _authService.getCurrentUser();
  }
}
