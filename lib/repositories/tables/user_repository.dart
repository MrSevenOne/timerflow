import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/models/user_model.dart';

class UserRepository {
  final supabase = Supabase.instance.client;
  final String table = 'users';

  Future<UserModel?> insertUser(UserModel user) async {
    final response = await supabase.from(table).insert(user.toJson()).select();

    if (response.isNotEmpty) {
      return UserModel.fromJson(response.first);
    }
    return null;
  }

  Future<List<UserModel>> getUsers() async {
    final response = await supabase.from(table).select().order('created_at');

    return response.map<UserModel>((item) => UserModel.fromJson(item)).toList();
  }

  Future<UserModel?> getUserById(String id) async {
    final response =
        await supabase.from(table).select().eq('id', id).maybeSingle();

    if (response == null) return null;

    return UserModel.fromJson(response);
  }

  /// user_id bo‘yicha statusni olish
  Future<bool> getUserStatus() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      // User login qilmagan
      return false;
    }

    try {
      final data = await supabase
          .from('users')
          .select('status')
          .eq('id', user.id)
          .maybeSingle();

      if (data == null) return false;

      return data['status'] as bool;
    } catch (e) {
      throw Exception('Failed to fetch user status: $e');
    }
  }

  Future<bool> updateUser(UserModel user) async {
    await supabase.from(table).update(user.toJson()).eq('id', user.id ?? '');
    return true;
  }

  Future<bool> deleteUser(String id) async {
    await supabase.from(table).delete().eq('id', id);
    return true;
  }
}
