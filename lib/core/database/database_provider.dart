import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database.dart';

/// ------------------------------------------------------------
/// AppDatabase Provider
/// ------------------------------------------------------------
/// Single instance of Drift DB for whole app.
/// ------------------------------------------------------------

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
