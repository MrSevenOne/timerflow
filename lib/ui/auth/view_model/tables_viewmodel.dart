import 'package:flutter/foundation.dart';
import 'package:timerflow/data/services/supabase/database/tables_service.dart';
import 'package:timerflow/domain/models/table_model.dart';
import 'package:timerflow/ui/widget/snackbar_widget.dart';

class TablesViewModel extends ChangeNotifier {
  final TablesService _service = TablesService();
  TablesViewModel() {}
  bool _isLoading = false;
  List<TableModel> _table = [];
  bool get isLoading => _isLoading;
  List<TableModel> get table => _table;

  Future<void> getTables() async {
    _setLoading(value: true);
    try {
      _table = await _service.getAllTables();
    } catch (e) {
      SnackBarWidget.showError("Get Table", "Error: $e");
    } finally {
      _setLoading(value: false);
    }
  }

  Future addTable({required TableModel tablemodel}) async {
    _setLoading(value: true);
    try {
      await _service.createTable(table: tablemodel);
      SnackBarWidget.showSuccess('${tablemodel.name}', "Successfully added");
      await getTables();
    } catch (e) {
      SnackBarWidget.showError("Add Table", "Error: $e");
      print(e);
    } finally {
      _setLoading(value: false);
    }
  }
  Future<void> updateTableStatus({
  required int tableId,
  required String newStatus,
}) async {
  _setLoading(value: true);
  try {
    await _service.updateTableStatus(tableId: tableId, newStatus: newStatus);
    await getTables();
  } catch (e) {
    SnackBarWidget.showError('Update Table', '$e');
  } finally {
    _setLoading(value: false);
  }
}


  Future deleteTable({required TableModel tablemodel}) async {
    try {
          _setLoading(value: true);
      await _service.deleteTable(id: tablemodel.id!);
      SnackBarWidget.showSuccess(tablemodel.name, 'successfully deleted');
      await getTables();
    } catch (e) {
      SnackBarWidget.showError('Error Delete Table', '$e');
    } finally {
      _setLoading(value: false);
    }
  }

  void _setLoading({required bool value}) {
    _isLoading = value;
    notifyListeners();
  }

}
