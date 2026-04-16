import 'dart:convert';

import '../database/daos/sync_queue_dao.dart';
import 'sync_queue.dart';

/// ------------------------------------------------------------
/// Drift-backed SyncQueue
/// ------------------------------------------------------------
/// This is the concrete implementation used in production.
/// ------------------------------------------------------------

class DriftSyncQueue implements SyncQueue {
  DriftSyncQueue(this._dao);

  final SyncQueueDao _dao;

  @override
  Future<void> enqueue(SyncQueueItem item) {
    return _dao.insertItem(
      id: item.id,
      actionType: item.type.name,
      entityType: item.entityType,
      payload: item.payload,
      createdAt: item.createdAt,
    );
  }

  @override
  Future<List<SyncQueueItem>> getPending() async {
    final rows = await _dao.getAll();

    return rows.map((row) {
      return SyncQueueItem(
        id: row.id,
        type: SyncActionType.values.byName(row.actionType),
        entityType: row.entityType,
        payload:
        jsonDecode(row.payloadJson) as Map<String, dynamic>,
        createdAt: row.createdAt,
      );
    }).toList();
  }

  @override
  Future<void> remove(String id) {
    return _dao.deleteById(id);
  }
}
