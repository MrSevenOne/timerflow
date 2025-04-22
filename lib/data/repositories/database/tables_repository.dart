import 'package:timerflow/data/services/supabase/database/tables_service.dart';
import 'package:timerflow/domain/models/table_model.dart';

class TableRepository {
  final TableService _tableService;

  TableRepository(this._tableService);
//ADD
  Future<List<TableModel>> getAllTables() async {
    try {
      return await _tableService.fetchTables();
    } catch (e) {
      throw 'getAllTables $e';
    }
  }

//CREATE
  Future<void> createTable(TableModel tableModel) async {
    try {
      await _tableService.addTable(tableModel: tableModel);
    } catch (e) {
      throw 'createTable $e';
    }
  }

//UPDATE
  Future<void> updateTable(TableModel tableModel) async {
    try {
      await _tableService.updateTable(tableModel: tableModel);
    } catch (e) {
      throw 'updateTable $e';
    }
  }

//DELETE
  Future<void> deleteTable(int tableId) async {
    try {
      await _tableService.deleteTable(tableId: tableId);
    } catch (e) {
      throw 'deleteTable $e';
    }
  }

//CHANGE STATUS
  Future<void> changeTableStatus({
    required int tableId,
    required String status,
  }) async {
    try {
      await _tableService.updateStatus(tableId: tableId, status: status);
    } catch (e) {
      throw 'changeTableStatus $e';
    }
  }
}
