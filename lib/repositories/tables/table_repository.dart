// lib/repositories/table_repository.dart

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:timerflow/models/table_model.dart';
import 'package:timerflow/services/remote/tables/table_supabase_service.dart';

class TableRepository {
  final Box<TableModel> tablesBox; // keyed by localId (String)
  final Box<String> settingsBox; // for LAST_SYNC_KEY etc.
  final TableSupabaseService supabaseService;

  // ignore: constant_identifier_names
  static const String LAST_SYNC_KEY = 'tables_last_sync';

  TableRepository({
    required this.tablesBox,
    required this.settingsBox,
    required this.supabaseService,
  });

  // --- Read local ---
  List<TableModel> getLocalTables() {
    return tablesBox.values.where((t) => !t.isDeletedLocally).toList();
  }

  // --- Create (local-first) ---
  Future<TableModel> createNewTable({
    required String name,
    required String type,
    required int price,
    required String userId,
  }) async {
    final now = DateTime.now().toUtc();
    final localId = now.toIso8601String(); // or use uuid
    final newTable = TableModel(
      localId: localId,
      name: name,
      type: type,
      hourPrice: price,
      userId: userId,
      createdAt: now,
      updatedAt: now,
      isSynced: false,
      isDirty: false,
      isDeletedLocally: false,
    );

    await tablesBox.put(localId, newTable);
    // start sync (caller can also call explicit sync)
    await trySync(); // attempt immediate sync if online
    return newTable;
  }

  // --- Update (local) ---
  Future<void> updateExistingTable(String localId, {
    String? name,
    String? type,
    int? hourPrice,
    bool? isActive,
  }) async {
    final table = tablesBox.get(localId);
    if (table == null) throw Exception('Table not found locally: $localId');

    table.name = name ?? table.name;
    table.type = type ?? table.type;
    table.hourPrice = hourPrice ?? table.hourPrice;
    table.isActive = isActive ?? table.isActive;
    table.updatedAt = DateTime.now().toUtc();
    // Mark dirty so that it will be uploaded
    table.isDirty = true;
    // If it was never synced (new local), leave isSynced = false
    await table.save();

    await trySync();
  }

  // --- Delete locally (soft delete if synced) ---
  Future<void> deleteTableLocally(String localId) async {
    final table = tablesBox.get(localId);
    if (table == null) return;
    if (table.id == null) {
      // never uploaded -> remove fully
      await table.delete(); // removes from box
    } else {
      // mark for deletion and upload delete on next sync
      table.isDeletedLocally = true;
      table.isDirty = false;
      table.updatedAt = DateTime.now().toUtc();
      await table.save();
    }
    await trySync();
  }

  // --- SYNC (public) ---
  Future<void> trySync() async {
    final connectivity = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    if (connectivity == ConnectivityResult.none) {
      // no internet
      return;
    }

    await _uploadLocalChanges();
    await _downloadServerChanges();
  }

  // --- Upload local changes to server ---
  Future<void> _uploadLocalChanges() async {
    final changes = tablesBox.values.where((t) => t.isDirty || !t.isSynced || t.isDeletedLocally).toList();

    for (final local in changes) {
      try {
        if (local.isDeletedLocally && local.id != null) {
          // DELETE on server, then remove locally
          await supabaseService.deleteTable(local.id!);
          await local.delete();
          continue;
        }

        if (!local.isSynced) {
          // INSERT to server
          final serverModel = await supabaseService.insertTable(local);
          // Update local entry: set server id and localId -> server id as canonical localId
          final newLocalId = serverModel.id!.toString();
          // Remove old local key and re-insert with server id as key to avoid duplicates
          await tablesBox.delete(local.localId);
          serverModel.localId = newLocalId;
          serverModel.isSynced = true;
          serverModel.isDirty = false;
          await tablesBox.put(newLocalId, serverModel);
          continue;
        }

        if (local.isDirty && local.id != null) {
          // UPDATE server
          final serverModel = await supabaseService.updateTable(local.id!, local);
          // Merge server's updatedAt/values into local, but keep local flags reset
          local
            ..name = serverModel.name
            ..type = serverModel.type
            ..hourPrice = serverModel.hourPrice
            ..isActive = serverModel.isActive
            ..updatedAt = serverModel.updatedAt.toUtc()
            ..isDirty = false
            ..isSynced = true;
          await local.save();
        }
      } catch (e) {
        // Log and continue — do not change flags so it will retry next time
        // You can add retry/circuit-breaker logic here if needed
        // debugPrint('Upload error for ${local.localId}: $e\n$st');
      }
    }
  }

  // --- Download server changes and merge ---
  Future<void> _downloadServerChanges() async {
    // Read last sync time from settingsBox (ISO string), default epoch 0
    final lastSyncIso = settingsBox.get(LAST_SYNC_KEY, defaultValue: DateTime.fromMillisecondsSinceEpoch(0).toUtc().toIso8601String())!;
    final lastSync = DateTime.parse(lastSyncIso).toUtc();

    final serverChanges = await supabaseService.fetchChanges(lastSync);

    for (final server in serverChanges) {
      final serverLocalId = server.id!.toString();
      final local = tablesBox.get(serverLocalId);

      if (local == null) {
        // New on server -> put locally
        server.isSynced = true;
        server.isDirty = false;
        server.isDeletedLocally = false;
        await tablesBox.put(serverLocalId, server);
      } else {
        // Both exist -> conflict resolution
        if (local.isDeletedLocally) {
          // local requested delete: prefer local delete (attempt to delete on server on next upload)
          // do nothing — upload step will handle deletion
          continue;
        }

        server.updatedAt.toUtc();
        local.updatedAt.toUtc();

        if (local.isDirty) {
          // conflict: local changed and server changed since last sync
          // Strategy: Local-wins (as you requested). So keep local and mark for upload.
          // But we should not blindly overwrite server; keep as is and ensure local.isDirty stays true.
          // Optionally, you can save a server copy to history or notify user.
          continue;
        } else {
          // server is newer and local not dirty -> overwrite local
          local
            ..name = server.name
            ..type = server.type
            ..hourPrice = server.hourPrice
            ..isActive = server.isActive
            ..createdAt = server.createdAt.toUtc()
            ..updatedAt = server.updatedAt.toUtc()
            ..isSynced = true
            ..isDirty = false;
          await local.save();
        }
      }
    }

    // update last sync time
    settingsBox.put(LAST_SYNC_KEY, DateTime.now().toUtc().toIso8601String());
  }
}
