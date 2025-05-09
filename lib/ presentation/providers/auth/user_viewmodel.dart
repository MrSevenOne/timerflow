import 'package:flutter/foundation.dart';
import 'package:timerflow/data/repositories/database/auth/user_repository.dart';
import 'package:timerflow/domain/models/user_model.dart';

class UserViewmodel extends ChangeNotifier {
  final UserRepository _repository;

  bool _isLoading = false;
  UserModel? _userModel;
  String _error = '';

  UserModel? get userModel => _userModel;
  bool get isLoading => _isLoading;
  String get error => _error;

  UserViewmodel(this._repository);

  Future<void> getUserInfo() async {
    _setLoading(true);
    _error = '';
    try {
      _userModel = await _repository.fetchUser();
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future addUser(UserModel userModel) async {
    _setLoading(true);
    try {
      await _repository.addUser(userModel: userModel);
    } catch (e) {
      debugPrint("Error Add User: $e");
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future updateUserInfo(UserModel userModel) async {
    _setLoading(true);
    try {
      await _repository.updateUserInfo(userModel: userModel);
      await getUserInfo();
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
