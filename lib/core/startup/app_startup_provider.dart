import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../connectivity/connectivity_provider.dart';
import '../database/database_provider.dart';

/// ------------------------------------------------------------
/// App Startup Provider
/// ------------------------------------------------------------
/// This provider is the SINGLE place where all app boot logic
/// lives. Anything required before showing the real app
/// should go here.
///
/// Examples:
/// - Open local database (Drift / Isar) I hate Isar so we use Drift
/// - Restore auth session
/// - Load persisted settings
/// - Initialize offline sync queue on offline first
/// - Setup connectivity listeners
/// - Warm up caches
/// - Initialize Firebase / Sentry / etc
///
/// This makes startup:
/// - Centralized
/// - Testable
/// - Predictable
/// ------------------------------------------------------------

final appStartupProvider = FutureProvider<void>((ref) async {
  // 1. Initialize local database
   ref.read(databaseProvider);

  // 2. Restore authentication session (tokens, user)
  // TODO: await ref.read(authRepositoryProvider).restoreSession();

  // 3. Load user/app settings
  // TODO: await ref.read(settingsRepositoryProvider).load();

  // 4. Initialize offline-first sync system
  // TODO: await ref.read(syncServiceProvider).initialize();

  // 5. Setup connectivity listeners
  await ref.read(connectivityServiceProvider).initialize();

  // 6. Optional: Warm up caches
  // TODO: await ref.read(cacheWarmupProvider).warm();

  // For now, we just simulate some startup work
  await Future.delayed(const Duration(milliseconds: 500));
});
