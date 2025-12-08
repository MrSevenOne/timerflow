// import 'dart:io';
// import 'package:drift/drift.dart';
// import 'package:drift/native.dart';
// import 'package:drift/web.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as p;
// import 'package:flutter/foundation.dart'; // kIsWeb

// // Web uchun drift_web
// import 'package:timerflow/models/local_table_model.dart';

// part 'app_database.g.dart';

// @DriftDatabase(tables: [TablesTable])
// class AppDatabase extends _$AppDatabase {
//   AppDatabase() : super(_openConnection());

//   @override
//   int get schemaVersion => 1;

//   // ===== CRUD METHODS =====

//   Future<int> addTable({
//     required String name,
//     required String type,
//     required int hourPrice,
//     required String userId,
//   }) {
//     return into(tablesTable).insert(
//       TablesTableCompanion.insert(
//         name: name,
//         type: type,
//         hourPrice: hourPrice,
//         userId: userId,
//       ),
//     );
//   }

//   Stream<List<TablesTableData>> watchTables() {
//     return select(tablesTable).watch();
//   }

//   Future<List<TablesTableData>> getAllTables() {
//     return select(tablesTable).get();
//   }

//   Future<bool> updateTable(TablesTableData table) {
//     return update(tablesTable).replace(table);
//   }

//   Future<int> deleteTable(int id) {
//     return (delete(tablesTable)..where((t) => t.id.equals(id))).go();
//   }
// }

// LazyDatabase _openConnection() {
//   return LazyDatabase(() async {
//     // Mobile/Desktop: Native SQLite
//     final dir = await getApplicationDocumentsDirectory();
//     final file = File(p.join(dir.path, 'app.sqlite'));
//     return NativeDatabase(file);
//   });
// }
