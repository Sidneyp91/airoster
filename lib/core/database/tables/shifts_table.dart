import 'package:drift/drift.dart';

/// ------------------------------------------------------------
/// Shifts Table (placeholder)
/// Update this once we have API Model entries
/// ------------------------------------------------------------


class ShiftsTable extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();
  TextColumn get content => text()();

  // API field
  DateTimeColumn get updatedAt => dateTime()();

  // ---- Offline-first fields (DB ONLY) ----
  BoolColumn get isDirty =>
      boolean().withDefault(const Constant(false))();

  BoolColumn get isDeleted =>
      boolean().withDefault(const Constant(false))();

  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
