import 'package:flutter/material.dart';
import 'package:timerflow/data/repositories/database/tables_repository.dart';
import 'package:timerflow/domain/models/table_model.dart';

class TableViewModel extends ChangeNotifier {
  final TableRepository _tableRepository;

  TableViewModel(this._tableRepository);
  

  List<TableModel> _tables = [];
  bool _isLoading = false;
  String? _error;

  List<TableModel> get tables => _tables;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch all tables
  Future<void> fetchTables() async {
    _setLoading(true);
    try {
      _tables = await _tableRepository.getAllTables();
      debugPrint('Table qoshildi');
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Add new table
  Future<void> addTable(TableModel table) async {
    try {
      await _tableRepository.createTable(table);
      await fetchTables();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Update table
  Future<void> updateTable(TableModel table) async {
    try {
      await _tableRepository.updateTable(table);
      await fetchTables();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Delete table
  Future<void> deleteTable(int tableId) async {
    try {
      await _tableRepository.deleteTable(tableId);
      _tables.removeWhere((t) => t.id == tableId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Change status
  Future<void> updateStatus(int tableId,status) async {
    try {
      await _tableRepository.changeTableStatus(
          tableId: tableId, status: status);
      await fetchTables();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
