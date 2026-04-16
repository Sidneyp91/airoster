import 'dart:async';

import 'package:flutter/foundation.dart';

import '../connectivity /connectivity_service.dart';
import 'sync_queue.dart';

/// ------------------------------------------------------------
/// Sync Service
/// ------------------------------------------------------------
/// Responsibilities:
/// - Listen for connectivity changes
/// - When online, drain sync queue
/// - Retry on failures
/// - Central place for sync orchestration
/// ------------------------------------------------------------

class SyncService {
  SyncService({
    required ConnectivityService connectivityService,
    required SyncQueue syncQueue,
  })  : _connectivityService = connectivityService,
        _syncQueue = syncQueue;

  final ConnectivityService _connectivityService;
  final SyncQueue _syncQueue;

  StreamSubscription<bool>? _connectivitySub;
  bool _isSyncing = false;

  Future<void> initialize() async {
    // Listen for connectivity changes
    _connectivitySub =
        _connectivityService.onStatusChange.listen((isOnline) {
          if (isOnline) {
            _trySync();
          }
        });

    // If already online at startup, sync immediately
    if (_connectivityService.isOnline) {
      _trySync();
    }
  }

  Future<void> _trySync() async {
    if (_isSyncing) return;

    _isSyncing = true;
    debugPrint('Starting sync...');

    try {
      final items = await _syncQueue.getPending();

      for (final item in items) {
        await _processItem(item);
        await _syncQueue.remove(item.id);
      }

      debugPrint('Sync completed successfully');
    } catch (e, st) {
      debugPrint('Sync failed: $e');
      debugPrint('$st');
      // Leave items in queue for retry
    } finally {
      _isSyncing = false;
    }
  }

  /// This is where you map queue items to API calls
  Future<void> _processItem(SyncQueueItem item) async {
    debugPrint(
      'Syncing ${item.entityType} ${item.type} id=${item.id}',
    );

    // TODO:
    // Switch by entityType + action
    // Call appropriate repository / API
    //
    // Example:
    // if (item.entityType == 'note') {
    //   await notesRemoteDataSource.sync(item);
    // }

    await Future.delayed(const Duration(milliseconds: 200));
  }

  void dispose() {
    _connectivitySub?.cancel();
  }
}
