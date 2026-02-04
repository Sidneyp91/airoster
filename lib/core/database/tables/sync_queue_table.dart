import 'package:drift/drift.dart';

/// ------------------------------------------------------------
/// Sync Queue Table
/// ------------------------------------------------------------
/// Persists offline actions so they survive:
/// - App restarts
/// - Crashes
/// - OS kills
///
/// This is the backbone of offline-first sync.
/// ------------------------------------------------------------

class SyncQueueTable extends Table {
  TextColumn get id => text()();

  // create / update / delete
  TextColumn get actionType => text()();

  // e.g. "shift", "task", "user"
  TextColumn get entityType => text()();

  // JSON payload (Freezed model .toJson())
  TextColumn get payloadJson => text()();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
