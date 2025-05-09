import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/domain/models/user_model.dart';

class UserService {
  final _client = Supabase.instance.client;
  final String tableName = 'users';
//GET
  Future<UserModel?> fetchUserByAuthId(String authId) async {
  final response = await _client
      .from(tableName)
      .select()
      .eq('auth_id', authId)
      .maybeSingle(); // returns null if not found

  if (response == null) return null;

  return UserModel.fromJson(response);
}


//ADD
  Future<void> addUser({required UserModel userModel}) async {
    await _client.from(tableName).insert(userModel.toJson());
  }

//UPDATE
  Future<void> updateUser({required UserModel userModel}) async {
    await _client
        .from(tableName)
        .update(userModel.toJson())
        .eq('id', userModel.id!);
  }
}
