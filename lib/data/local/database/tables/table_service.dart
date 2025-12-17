import 'package:timerflow/data/local/database/app_database.dart';
import 'package:timerflow/models/table/table_model.dart';

class TableHiveService extends BaseHiveService<TableModel> {
  @override
  String get boxName => 'tablesBox';

  Future<void> saveTables(List<TableModel> tables) async {
    for (var t in tables) {
      await put(t.id, t);
    }
  }

  Future<List<TableModel>> getUnsynced() async {
    final all = await getAll();
    return all.where((t) => !t.isSynced).toList();
  }
}
