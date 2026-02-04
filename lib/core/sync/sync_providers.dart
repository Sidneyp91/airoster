import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../connectivity /connectivity_provider.dart';
import '../database/database_provider.dart';
import '../database/daos/sync_queue_dao.dart';
import 'drift_sync_queue.dart';
import 'sync_queue.dart';
import 'sync_service.dart';

final syncQueueDaoProvider = Provider<SyncQueueDao>((ref) {
  final db = ref.watch(databaseProvider);
  return SyncQueueDao(db);
});

/// Replace UnimplementedError with Drift implementation
final syncQueueProvider = Provider<SyncQueue>((ref) {
  final dao = ref.watch(syncQueueDaoProvider);
  return DriftSyncQueue(dao);
});

final syncServiceProvider = Provider<SyncService>((ref) {
  final connectivityService = ref.watch(connectivityServiceProvider);
  final syncQueue = ref.watch(syncQueueProvider);

  final service = SyncService(
    connectivityService: connectivityService,
    syncQueue: syncQueue,
  );

  ref.onDispose(service.dispose);
  return service;
});
