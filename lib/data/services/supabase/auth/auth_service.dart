
import 'package:timerflow/exports.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  /// SIGN IN
  Future<AuthResponse?> signIn(String email, String password) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } on AuthException catch (e) {
      throw Exception('Login failed: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// SIGN UP
  Future<AuthResponse?> signUp(String email, String password) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        
      );
      return response;
    } on AuthException catch (e) {
      throw Exception('Signup failed: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// SIGN OUT
  Future<void> signOut({SignOutScope scope = SignOutScope.local}) async {
    try {
      await _client.auth.signOut(scope: scope);
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  /// GET CURRENT USER
  User? getCurrentUser() {
    return _client.auth.currentUser;
  }

  /// GET SESSION TOKEN
  Session? getCurrentSession() {
    return _client.auth.currentSession;
  }

Future<String?> getCurrentUserId() async {
  final user = Supabase.instance.client.auth.currentUser;
  return user?.id;
}

}