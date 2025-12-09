import 'package:timerflow/models/table_model.dart';
import 'package:timerflow/providers/base_viewmodel.dart';
import 'package:timerflow/repositories/tables/table_repository.dart';

class TableViewModel extends BaseViewModel {
  final TableRepository _repository;

  /// Lokal va serverdan olingan table lar
  List<TableModel> tables = [];

  TableViewModel({required TableRepository repository})
      : _repository = repository;

  /// Init: lokal ma'lumotlarni yuklash va sinxronizatsiya qilish
  Future<void> init() async {
    await runFuture(() async {
      // 1️⃣ Lokal bazadan table larni o‘qish
      tables = _repository.getLocalTables();

      // 2️⃣ Sinxronizatsiya (internet bor bo‘lsa) — upload + download
      await _repository.trySync();

      // 3️⃣ Sinxronizatsiyadan so‘ng lokal bazani yangilash
      tables = _repository.getLocalTables();
    });
  }

  /// Stol qo‘shish (lokal + sinxronizatsiya)
  Future<void> addTable({
    required String name,
    required String type,
    required int hourPrice,
    required String userId,
  }) async {
    await runFuture(() async {
      final newTable = await _repository.createNewTable(
        name: name,
        type: type,
        price: hourPrice,
        userId: userId,
      );

      // UI uchun qo‘shish
      tables.add(newTable);
      setSuccess("Stol muvaffaqiyatli qo‘shildi");
    });
  }

  /// Stolni tahrirlash (lokal + serverga push)
  Future<void> updateTable(
    String localId, {
    String? name,
    String? type,
    int? hourPrice,
    bool? isActive,
  }) async {
    await runFuture(() async {
      await _repository.updateExistingTable(
        localId,
        name: name,
        type: type,
        hourPrice: hourPrice,
        isActive: isActive,
      );

      // UI yangilash
      tables = _repository.getLocalTables();
      setSuccess("Stol muvaffaqiyatli yangilandi");
    });
  }

  /// Stolni o‘chirish
  Future<void> deleteTable(String localId) async {
    await runFuture(() async {
      await _repository.deleteTableLocally(localId);

      // UI yangilash
      tables = _repository.getLocalTables();
      setSuccess("Stol muvaffaqiyatli o‘chirildi");
    });
  }

  /// Qo‘lda sinxronizatsiya
  Future<void> syncTables() async {
    await runFuture(() async {
      await _repository.trySync();
      tables = _repository.getLocalTables();
      setSuccess("Sinxronizatsiya yakunlandi");
    });
  }
}
