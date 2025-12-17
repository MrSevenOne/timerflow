import 'package:timerflow/data/local/database/tables/table_service.dart';
import 'package:timerflow/data/remote/network_service.dart';
import 'package:timerflow/data/remote/supabase/tables/table_service.dart';
import 'package:timerflow/models/table/table_model.dart';
import 'package:timerflow/utils/user_manager.dart';

class TableRepository {
  final TableSupabaseService apiService;
  final TableHiveService hiveService;
  final NetworkService networkService;

  TableRepository({
    required this.apiService,
    required this.hiveService,
    required this.networkService,
  });

  /// GET TABLES (USER-BASED, OFFLINE-FIRST)
  Future<List<TableModel>> getTables({bool forceRefresh = false}) async {
    final localTables = await hiveService.getAll();
    final hasCache = localTables.isNotEmpty;
    final userId = UserManager.userId;

    // 1️⃣ Local cache
    if (hasCache && !forceRefresh) return localTables;

    // 2️⃣ Internet yo‘q → local data
    if (!await networkService.hasInternet) {
      if (hasCache) return localTables;
      throw Exception('Internet yo‘q va local maʼlumot yo‘q');
    }

    // 3️⃣ API fetch
    try {
      final apiTables = await apiService.fetchAll(userId);
      await mergeTables(apiTables); // merge local + api
      return await hiveService.getAll();
    } catch (e) {
      if (hasCache) return localTables;
      rethrow;
    }
  }

  /// ADD TABLE (offline-first)
  Future<void> addTable(TableModel table) async {
    final tableWithUser = table.copyWith(
      userId: UserManager.userId,
      isSynced: false,
    );

    // 1️⃣ Local qo‘shish
    await hiveService.put(tableWithUser.id, tableWithUser);

    // 2️⃣ Internet bo‘lsa push
    if (await networkService.hasInternet) {
      await syncPendingTables();
    }
  }

  /// Hive'dagi unsynced table'larni API ga yuborish
  Future<void> syncPendingTables() async {
    final pendingTables = await hiveService.getUnsynced();

    for (var table in pendingTables) {
      try {
        // UPSERT bilan serverga yuborish
        final serverTable = await apiService.upsertTable(table);
        // Hive update → isSynced = true
        await hiveService.put(
          serverTable.id,
          serverTable.copyWith(isSynced: true),
        );
        print('Table "${table.name}" synced ✅');
      } catch (e) {
        print('Failed to sync "${table.name}": $e');
      }
    }
  }

  /// API datani local bilan merge qilish (unsynced table saqlanadi)
  Future<void> mergeTables(List<TableModel> apiTables) async {
    final unsynced = await hiveService.getUnsynced();
    final merged = [...unsynced];

    for (var t in apiTables) {
      if (!merged.any((u) => u.id == t.id)) merged.add(t);
    }

    await hiveService.saveTables(merged);
  }
}
