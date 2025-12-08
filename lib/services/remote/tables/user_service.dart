import 'package:timerflow/models/user_model.dart';
import 'package:timerflow/repositories/tables/user_repository.dart';

class UserService {
  final UserRepository _repository = UserRepository();

  Future<UserModel?> createUser(UserModel model) async {
    return await _repository.insertUser(model);
  }

  Future<List<UserModel>> fetchUsers() async {
    return await _repository.getUsers();
  }

  Future<UserModel?> fetchUserById(String id) async {
    return await _repository.getUserById(id);
  }

  Future<bool> updateUser(UserModel model) async {
    return await _repository.updateUser(model);
  }

  Future<bool> getUserStatus() async {
    return  _repository.getUserStatus();
  }

  Future<bool> deleteUser(String id) async {
    return await _repository.deleteUser(id);
  }
}
