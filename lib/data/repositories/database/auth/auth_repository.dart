import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/data/services/supabase/database/auth/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  /// SIGN IN
  Future<AuthResponse?> signIn(String email, String password) {
    return _authService.signIn(email, password);
  }

  /// SIGN UP
  Future<AuthResponse?> signUp(String email, String password) {
    return _authService.signUp(email, password);
  }

  /// SIGN OUT (optionally use scope if needed)
  Future<void> signOut({SignOutScope scope = SignOutScope.local}) {
    return _authService.signOut(scope: scope);
  }

  /// GET CURRENT USER
  User? getCurrentUser() {
    return _authService.getCurrentUser();
  }

  /// GET CURRENT SESSION
  Session? getCurrentSession() {
    return _authService.getCurrentSession();
  }
}
