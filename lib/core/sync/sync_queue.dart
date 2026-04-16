/// This must be synced when network is available
enum SyncActionType { create, update, delete }

class SyncQueueItem {
  final String id;
  final SyncActionType type;
  final String entityType; // e.g. "shift", "user", "task"
  final Map<String, dynamic> payload;
  final DateTime createdAt;

  const SyncQueueItem({
    required this.id,
    required this.type,
    required this.entityType,
    required this.payload,
    required this.createdAt,
  });
}

/// ------------------------------------------------------------
/// Sync Queue Abstraction
/// ------------------------------------------------------------
/// In production, implement this with:
/// - Drift (SQLite)
///
/// ------------------------------------------------------------

abstract class SyncQueue {
  Future<void> enqueue(SyncQueueItem item);

  Future<List<SyncQueueItem>> getPending();

  Future<void> remove(String id);
}
