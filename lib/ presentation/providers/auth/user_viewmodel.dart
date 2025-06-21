import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
    try {
      final authId = Supabase.instance.client.auth.currentUser?.id;
      debugPrint("AUTH ID: $authId");
      if (authId == null) {
        _error = "Foydalanuvchi tizimga kirmagan";
      } else {
        _userModel = await _repository.fetchUser();
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addUser(UserModel userModel) async {
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

  Future<void> updateUserInfo(UserModel userModel) async {
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

  Future<void> updateFullUser(UserModel userModel) async {
    _setLoading(true);
    try {
      await _repository.updateFullUser(userModel: userModel);
      await getUserInfo(); // refresh
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
