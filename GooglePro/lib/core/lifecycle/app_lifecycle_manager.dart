import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../services/device_presence_service.dart';
import '../utils/app_logger.dart';

@singleton
class AppLifecycleManager extends WidgetsBindingObserver {
  final DevicePresenceService _presence;
  String? _deviceId;

  AppLifecycleManager(this._presence);

  void initialize({required String? deviceId}) {
    _deviceId = deviceId;
    WidgetsBinding.instance.addObserver(this);
    AppLogger.info('AppLifecycleManager initialized');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    AppLogger.info('Lifecycle: $state');
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null || _deviceId == null) return;
    switch (state) {
      case AppLifecycleState.resumed:
        _presence.startPresence(deviceId: _deviceId!);
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        // Don't stop presence — foreground service handles it
        break;
      default:
        break;
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _presence.stopPresence();
  }
}
