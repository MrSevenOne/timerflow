import 'package:flutter/material.dart';
import 'package:timerflow/models/table_model.dart';
import 'package:timerflow/providers/base_viewmodel.dart';
import 'package:timerflow/repositories/tables/usertariff_repository.dart';
import 'package:timerflow/services/remote/tables/table_supabase_service.dart';
import 'package:timerflow/services/remote/tables/usertariff_service.dart';
import 'package:timerflow/services/remote/user_manager.dart';

class TableViewModel extends BaseViewModel {
  final TableService _tableService = TableService();
  final UserTariffService _tariffService =
      UserTariffService(repository: UserTariffRepository());

  List<TableModel> tables = [];
  int userTableLimit = 0;

  final UserManager _userManager = UserManager();

  /// Init: tarif va table larni yuklash
  Future<void> init() async {
    await runFuture(() async {
      await loadUserTariff();
      await loadTables();
    });
  }

  /// User obuna bo‘lgan tarif bo‘yicha table limit
  Future<void> loadUserTariff() async {
    userTableLimit = await _tariffService.getUserTableLimitCount();
    debugPrint("Userga ruxsat berilgan stol limiti: $userTableLimit");
  }

  /// Barcha table larni yuklash
  Future<void> loadTables() async {
    tables = await _tableService.getTables();
    debugPrint("Jami mavjud stol: ${tables.length}");
  }

  /// Stol qo‘shish (limit tekshiriladi)
  Future<void> addTable(TableModel table) async {
    await runFuture(() async {
      // LIMIT tekshirish
      if (tables.length >= userTableLimit) {
        setError("Sizning tarifingiz bo‘yicha faqat $userTableLimit ta stol yaratishingiz mumkin.");
        return;
      }

      // userId ni auth user bilan belgilash
      final tableWithUser = table.copyWith(userId: _userManager.requireUserId());

      final newTable = await _tableService.addTable(tableWithUser);

      if (newTable != null) {
        tables.add(newTable);
        setSuccess("Stol muvaffaqiyatli qo‘shildi");
      } else {
        setError("Stol qo‘shishda xatolik");
      }
    });
  }

  /// Stolni o‘chirish
  Future<void> deleteTable(int serverId) async {
    await runFuture(() async {
      final success = await _tableService.deleteTable(serverId);
      if (success) {
        tables.removeWhere((t) => t.serverId == serverId);
        setSuccess("Stol muvaffaqiyatli o‘chirildi");
      } else {
        setError("Stolni o‘chirishda xatolik");
      }
    });
  }
}
