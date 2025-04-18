import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  // Ro'yxatdan o'tish
  Future<AuthResponse?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
      );
      return response;
    } on AuthException catch (e) {
      print('AuthException: ${e.message}');
      return null;
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  // Tizimga kirish
  Future<AuthResponse?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } on AuthException catch (e) {
      print('AuthException: ${e.message}');
      return null;
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  // Tizimdan chiqish
  Future<bool> signOut() async {
    try {
      await _client.auth.signOut();
      return true;
    } on AuthException catch (e) {
      print('AuthException: ${e.message}');
      return false;
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }

  // Hozirgi foydalanuvchi
  User? get currentUser => _client.auth.currentUser;

  // Auth holati o'zgarishini kuzatish
  Stream<AuthState> get authState => _client.auth.onAuthStateChange;
}
