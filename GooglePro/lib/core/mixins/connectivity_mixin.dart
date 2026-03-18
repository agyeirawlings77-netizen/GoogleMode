import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import '../utils/app_logger.dart';

mixin ConnectivityMixin<T extends StatefulWidget> on State<T> {
  StreamSubscription? _connectivitySub;
  bool _isConnected = true;
  bool get isConnected => _isConnected;

  @override
  void initState() {
    super.initState();
    _listenConnectivity();
  }

  @override
  void dispose() {
    _connectivitySub?.cancel();
    super.dispose();
  }

  void _listenConnectivity() {
    _connectivitySub = Connectivity().onConnectivityChanged.listen((result) {
      final connected = !result.contains(ConnectivityResult.none);
      if (_isConnected != connected) {
        _isConnected = connected;
        AppLogger.info('Connectivity: ${connected ? "online" : "offline"}');
        if (mounted) { setState(() {}); onConnectivityChanged(connected); }
      }
    });
  }

  void onConnectivityChanged(bool isConnected) {}
}
