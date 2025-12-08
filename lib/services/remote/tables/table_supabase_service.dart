import 'dart:developer';

import 'package:timerflow/models/table_model.dart';
import 'package:timerflow/repositories/tables/table_repository.dart';

class TableService {
  final TableRepository _repo = TableRepository();

  Future<List<TableModel>> getTables() async {
    try {
      log("Fetching tables...");
      return await _repo.fetchTables();
    } catch (e, s) {
      log("ERROR getTables: $e", stackTrace: s);
      return [];
    }
  }

  Future<TableModel?> addTable(TableModel table) async {
    try {
      log("Adding table: ${table.name}");
      return await _repo.insertTable(table);
    } catch (e, s) {
      log("ERROR addTable: $e", stackTrace: s);
      return null;
    }
  }

  Future<bool> updateTable(TableModel table) async {
    try {
      if (table.serverId == null) {
        log("ERROR updateTable: serverId is null");
        return false;
      }
      log("Updating table id=${table.serverId}");
      return await _repo.updateTable(table.serverId!, table);
    } catch (e, s) {
      log("ERROR updateTable: $e", stackTrace: s);
      return false;
    }
  }

  Future<bool> deleteTable(int id) async {
    try {
      log("Deleting table id=$id");
      return await _repo.deleteTable(id);
    } catch (e, s) {
      log("ERROR deleteTable: $e", stackTrace: s);
      return false;
    }
  }
}
