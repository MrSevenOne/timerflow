import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/data/services/supabase/database/auth/user_service.dart';
import 'package:timerflow/domain/models/user_model.dart';

class UserRepository {
  final UserService _userService;

  UserRepository(this._userService);

  Future<UserModel?> fetchUser() async {
    try {
      final authId = Supabase.instance.client.auth.currentUser?.id;
      if (authId == null) throw 'No logged-in user found';
      return await _userService.fetchUserByAuthId(authId);
    } catch (e) {
      throw 'fetchUser $e';
    }
  }

  Future<void> addUser({required UserModel userModel}) async {
    try {
      await _userService.addUser(userModel: userModel);
    } catch (e) {
      throw 'addUser $e';
    }
  }

  Future<void> updateUserInfo({required UserModel userModel}) async {
    try {
      await _userService.updateUser(userModel: userModel);
    } catch (e) {
      throw 'updateUserInfo $e';
    }
  }

  Future<void> updateFullUser({required UserModel userModel}) async {
    try {
      await _userService.updateFullUser(userModel: userModel);
    } catch (e) {
      throw 'updateFullUser $e';
    }
  }
}
