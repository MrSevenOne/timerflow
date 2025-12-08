import 'package:timerflow/models/user_model.dart';
import 'package:timerflow/repositories/auth/auth_repository.dart';
import 'package:timerflow/repositories/tables/user_repository.dart';

class AuthService {
  final AuthRepository _authRepo = AuthRepository();
  final UserRepository _userRepo = UserRepository();

  // REGISTER + Insert into "users" table
  Future<UserModel?> register(
      UserModel model) async {
    final result = await _authRepo.signUp(model);

    if (result.user == null) return null;

    // Supabase auth uuid
    final userId = result.user!.id;

    // users tablega yozish
    final userModel = UserModel(
      id: userId,
      name: model.name,
      email: model.email,
      password: model.password, // xohlasangiz hashlab beraman
      status: false,
      createdAt: DateTime.now(),
    );

    return await _userRepo.insertUser(userModel);
  }

  // LOGIN
  Future<bool> login(String email, String password) async {
    final response = await _authRepo.signIn(email, password);
    return response.session != null;
  }

  // LOGOUT
  Future<void> logout() async {
    await _authRepo.signOut();
  }

  // Get current user
  UserModel? parseUser(Map<String, dynamic>? json) {
    if (json == null) return null;
    return UserModel.fromJson(json);
  }
}
