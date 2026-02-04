import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

/// ------------------------------------------------------------
/// Connectivity Service
/// ------------------------------------------------------------
/// Single responsibility:
/// - Listen to network changes
/// - Expose simple online/offline stream
/// - Hide platform/plugin details from rest of app
/// ------------------------------------------------------------

class ConnectivityService {
  ConnectivityService(this._connectivity);

  final Connectivity _connectivity;

  final _controller = StreamController<bool>.broadcast();

  Stream<bool> get onStatusChange => _controller.stream;

  bool _isOnline = false;
  bool get isOnline => _isOnline;

  Future<void> initialize() async {
    // Initial check
    final result = await _connectivity.checkConnectivity();
    _updateStatus(result);

    // Listen for changes
    _connectivity.onConnectivityChanged.listen(_updateStatus);
  }

  void _updateStatus(List<ConnectivityResult> result) {
    final online = !result.contains(ConnectivityResult.none);

    if (_isOnline != online) {
      _isOnline = online;
      _controller.add(_isOnline);
      debugPrint('Connectivity changed: online=$_isOnline');
    }
  }

  void dispose() {
    _controller.close();
  }
}
