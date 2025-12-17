import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/models/user_model.dart';

class AuthRepository {
  final SupabaseClient _client = Supabase.instance.client;

  // REGISTER (AUTH + USERS TABLE)
  Future<AuthResponse> signUp(UserModel model) async {
    return await _client.auth.signUp(
      email: model.email,
      password: model.password,
       data: {
        'full_name': model.name,
        'phone_number': "123456789",
      },
    );
  }

  // LOGIN
  Future<AuthResponse> signIn(String email, String password) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // LOGOUT
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  // CURRENT SESSION
  Session? getSession() {
    return _client.auth.currentSession;
  }

  // CURRENT USER
  User? getUser() {
    return _client.auth.currentUser;
  }
}
