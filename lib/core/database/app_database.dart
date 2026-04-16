import 'dart:io';

import 'package:airoster/core/database/tables/shifts_table.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'daos/shifts_dao.dart';
import 'daos/sync_queue_dao.dart';
import 'tables/sync_queue_table.dart';

part 'app_database.g.dart';

/// ------------------------------------------------------------
/// App Database
/// ------------------------------------------------------------
/// Central Drift database.
/// Add all tables + DAOs here.
/// ------------------------------------------------------------

@DriftDatabase(
  tables: [
    ShiftsTable,
    SyncQueueTable,
  ],
  daos: [
    ShiftsDao,
    SyncQueueDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// Future migrations go here
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      // TODO: handle migrations
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    //TODO :: get device directory and set path
    return NativeDatabase.createInBackground(File('app.db'));
  });
}
