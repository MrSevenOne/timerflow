import 'package:drift/drift.dart';

class LocalTables extends Table {
  IntColumn get id => integer()(); // Supabase bigint → int OK (fits Flutter)
  TextColumn get name => text()();
  TextColumn get type => text()();
  IntColumn get hourPrice => integer().named("hour_price")();
  BoolColumn get isActive => boolean().named("is_active").withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().named("created_at").nullable()();
  DateTimeColumn get updatedAt => dateTime().named("updated_at").nullable()();
  TextColumn get userId => text().named("user_id")();

  @override
  Set<Column> get primaryKey => {id};
}
