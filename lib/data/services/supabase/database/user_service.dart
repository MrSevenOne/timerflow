import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/data/services/supabase/auth/auth_service.dart';
import 'package:timerflow/domain/models/user_model.dart';

class UserService {
  final SupabaseClient _client = Supabase.instance.client;
  final AuthService _authService = AuthService();

  /// Fetch user info for currently logged in user
  Future<UserModel?> fetchCurrentUserInfo() async {
    try {
      final userId = await _authService.getCurrentUserId();
      if (userId == null) throw 'User not logged in';

      final data =
          await _client.from('users').select().eq('auth_id', userId).single();

      return UserModel.fromJson(data);
    } catch (e) {
      throw 'fetchUserByAuthId error: $e';
    }
  }

  /// Fetch user info by specific auth ID
  Future<UserModel?> fetchUserInfo(String authId) async {
    try {
      final data =
          await _client.from('users').select().eq('auth_id', authId).single();

      return UserModel.fromJson(data);
    } catch (e) {
      throw 'fetchUserByAuthId error: $e';
    }
  }

  /// Add new user to 'users' table
  Future<void> addUser({required UserModel userModel}) async {
    try {
      await _client.from('users').insert(userModel.toJson());
    } catch (e) {
      throw 'addUser error: $e';
    }
  }

  /// Update existing user info
  Future<void> updateUser({required UserModel userModel}) async {
    try {
      await _client
          .from('users')
          .update(userModel.toJson())
          .eq('auth_id', userModel.authId as Object);
    } catch (e) {
      throw 'updateUser error: $e';
    }
  }

  /// Update both users table and auth user info
  Future<void> updateFullUser({required UserModel userModel}) async {
    try {
      // 1. Update `users` table
      await _client.from('users').update({
        'name': userModel.name,
        'email': userModel.email,
        'password': userModel.password,
      }).eq('auth_id', userModel.authId!); // ✅ TO‘G‘RI: UUID ni tekshir

      // 2. Update auth.users
      final response = await _client.auth.updateUser(
        UserAttributes(
          email: userModel.email,
          password: userModel.password,
        ),
      );

      if (response.user == null) {
        throw Exception("Auth update failed");
      }
    } catch (e) {
      throw Exception('Update failed: $e');
    }
  }
}
