import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'connectivity_service.dart';

/// Low-level plugin provider (easy to mock in tests)
final connectivityPluginProvider = Provider<Connectivity>((ref) {
  return Connectivity();
});

/// ConnectivityService provider
final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  final plugin = ref.watch(connectivityPluginProvider);
  final service = ConnectivityService(plugin);

  ref.onDispose(service.dispose);
  return service;
});

/// Simple online/offline state for UI + logic
final isOnlineProvider = StreamProvider<bool>((ref) async* {
  final service = ref.watch(connectivityServiceProvider);

  // Emit current state first
  yield service.isOnline;

  // Then emit changes
  yield* service.onStatusChange;
});
