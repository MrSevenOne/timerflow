import 'package:flutter/material.dart';
import 'package:timerflow/models/user_tariff_model.dart';
import 'package:timerflow/repositories/tables/usertariff_repository.dart';

class UserTariffService {
  final UserTariffRepository repository;

  UserTariffService({required this.repository});

  // id bo‘yicha olish
  Future<UserTariffModel?> fetchUserTariffById(int id) async {
    try {
      return await repository.getById(id);
    } catch (e) {
      throw Exception('Service error while fetching user tariff by id: $e');
    }
  }

  // UPSERT (create/update bir joyda, user_id yagona)
  Future<UserTariffModel> upsertUserTariff(UserTariffModel userTariff) async {
    try {
      return await repository.upsert(userTariff);
    } catch (e) {
      throw Exception('Service error while upserting user tariff: $e');
    }
  }

  // delete
  Future<bool> deleteUserTariff(int id) async {
    try {
      return await repository.delete(id);
    } catch (e) {
      throw Exception('Service error while deleting user tariff: $e');
    }
  }

  Future<bool> hasUserTariff() async {
    try {
      return await repository.hasUserTariffForCurrentUser();
    } catch (e) {
      throw Exception('Service error while hasUserTariff user tariff: $e');
    }
  }

  //get user table limit count
  Future<int> getUserTableLimitCount() async {
    try {
      return await repository.getCurrentUserTableLimit();
    } catch (e) {
      debugPrint('getUserTableLimitCount muamo bor: $e');
      throw Exception('getUserTableLimitCount muamo bor: $e');
    }
  }
}
