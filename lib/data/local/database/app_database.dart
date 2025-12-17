import 'package:hive_flutter/hive_flutter.dart';

abstract class BaseHiveService<T> {
  /// Box nomi (har bir model o'zinikini beradi)
  String get boxName;

  /// Box ochish
  Future<Box<T>> openBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<T>(boxName);
    }
    return await Hive.openBox<T>(boxName);
  }

  /// CREATE / UPDATE
  Future<void> put(dynamic key, T value) async {
    final box = await openBox();
    await box.put(key, value);
  }

  /// BULK CREATE / UPDATE
  Future<void> putAll(Map<dynamic, T> values) async {
    final box = await openBox();
    await box.putAll(values);
  }

  /// READ (bitta)
  Future<T?> get(dynamic key) async {
    final box = await openBox();
    return box.get(key);
  }

  /// READ (hammasi)
  Future<List<T>> getAll() async {
    final box = await openBox();
    return box.values.toList();
  }

  /// DELETE (bitta)
  Future<void> delete(dynamic key) async {
    final box = await openBox();
    await box.delete(key);
  }

  /// DELETE (hammasi)
  Future<void> clear() async {
    final box = await openBox();
    await box.clear();
  }

  /// CHECK EMPTY
  Future<bool> isEmpty() async {
    final box = await openBox();
    return box.isEmpty;
  }

  /// BOX CLOSE (ixtiyoriy)
  Future<void> close() async {
    if (Hive.isBoxOpen(boxName)) {
      await Hive.box(boxName).close();
    }
  }
}
