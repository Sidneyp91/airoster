import 'dart:convert';

import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/sync_queue_table.dart';

part 'sync_queue_dao.g.dart';

/// ------------------------------------------------------------
/// Sync Queue DAO
/// ------------------------------------------------------------
/// Low-level DB access for sync queue.
/// ------------------------------------------------------------

@DriftAccessor(tables: [SyncQueueTable])
class SyncQueueDao extends DatabaseAccessor<AppDatabase>
    with _$SyncQueueDaoMixin {
  SyncQueueDao(super.db);

  Future<void> insertItem({
    required String id,
    required String actionType,
    required String entityType,
    required Map<String, dynamic> payload,
    required DateTime createdAt,
  }) {
    return into(syncQueueTable).insert(
      SyncQueueTableCompanion.insert(
        id: id,
        actionType: actionType,
        entityType: entityType,
        payloadJson: jsonEncode(payload),
        createdAt: createdAt,
      ),
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<List<SyncQueueTableData>> getAll() {
    return select(syncQueueTable).get();
  }

  Future<void> deleteById(String id) {
    return (delete(syncQueueTable)
      ..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}
