import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/shifts_table.dart';

part 'shifts_dao.g.dart';

/// ------------------------------------------------------------
/// Notes DAO (Template)
/// ------------------------------------------------------------
/// Shows how you'll interact with entity tables.
/// ------------------------------------------------------------

@DriftAccessor(tables: [ShiftsTable])
class ShiftsDao extends DatabaseAccessor<AppDatabase>
    with _$ShiftsDaoMixin {
  ShiftsDao(super.db);

  Future<void> upsertNote(ShiftsTableCompanion companion) {
    return into(shiftsTable).insert(
      companion,
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<List<ShiftsTableData>> getAllNotes() {
    return select(shiftsTable).get();
  }

  Future<List<ShiftsTableData>> getDirtyNotes() {
    return (select(shiftsTable)
      ..where((tbl) => tbl.isDirty.equals(true)))
        .get();
  }
}
