import 'package:flutter/material.dart';
import 'package:timerflow/data/remote/supabase/tables/user_service.dart';
import 'package:timerflow/models/user_model.dart';

class UserViewModel extends ChangeNotifier {
  final UserService _service = UserService();

  bool isLoading = false;
  String? errorMessage;

  List<UserModel> users = [];

  /// SET LOADING
  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  /// GET ALL USERS
  Future<void> getAllUsers() async {
    try {
      _setLoading(true);
      users = await _service.fetchUsers();
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

//GET USER STATUS
  Future<bool> getUserStatus() async {
    _setLoading(true);
    notifyListeners();
    try {
      final result = _service.getUserStatus();
      return result;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// ADD USER
  Future<bool> addUser(UserModel model) async {
    try {
      _setLoading(true);
      final user = await _service.createUser(model);

      if (user != null) {
        users.add(user);
        notifyListeners();
        return true;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    return false;
  }

  /// UPDATE USER
  Future<bool> updateUser(UserModel model) async {
    try {
      _setLoading(true);
      final updated = await _service.updateUser(model);

      if (updated) {
        final index = users.indexWhere((u) => u.id == model.id);
        if (index != -1) {
          users[index] = model;
          notifyListeners();
        }
        return true;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    return false;
  }

  /// DELETE USER
  Future<bool> deleteUser(String id) async {
    try {
      _setLoading(true);
      final deleted = await _service.deleteUser(id);

      if (deleted) {
        users.removeWhere((u) => u.id == id);
        notifyListeners();
        return true;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    return false;
  }
}
