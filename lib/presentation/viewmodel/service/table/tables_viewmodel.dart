import 'package:timerflow/data/repository/tables/table_repository.dart';
import 'package:timerflow/models/table/table_model.dart';
import 'package:timerflow/presentation/viewmodel/base_viewmodel.dart';

class TableViewModel extends BaseViewModel {
  final TableRepository _repository;

  TableViewModel(this._repository);

  List<TableModel> _tables = [];
  List<TableModel> get tables => _tables;

  /// Load tables (offline-first + merge + sync)
  Future<void> loadTables({bool forceRefresh = false}) async {
    await runFuture(() async {
      // 1️⃣ Local + API merge
      _tables = await _repository.getTables(forceRefresh: forceRefresh);

      // 2️⃣ Internet bo‘lsa pending table’larni sync qilish
      if (await _repository.networkService.hasInternet) {
        await _repository.syncPendingTables();
        // 3️⃣ Syncdan keyin yangilangan list
        _tables = await _repository.getTables(forceRefresh: true);
      }

      notifyListeners();
    });
  }

  /// Add table (offline-first)
  Future<void> addTable(TableModel table) async {
    await runFuture(() async {
      await _repository.addTable(table);
      _tables = await _repository.getTables(); // UI darhol yangilanadi
      notifyListeners();
      setSuccess('Table added successfully');
    });
  }

  /// Force refresh (API fetch)
  Future<void> refresh() async {
    await loadTables(forceRefresh: true);
  }

  /// Clear tables list
  void clearTables() {
    _tables = [];
    notifyListeners();
  }
}
