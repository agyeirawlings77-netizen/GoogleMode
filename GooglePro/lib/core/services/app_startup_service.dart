import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'native_channel_service.dart';
import '../utils/app_logger.dart';

@singleton
class AppStartupService {
  final NativeChannelService _native;
  AppStartupService(this._native);

  Future<void> initialize() async {
    AppLogger.info('App startup: initializing...');
    await Future.wait([_startForegroundService(), _scheduleAutoConnect()]);
    AppLogger.info('App startup: complete');
  }

  Future<void> _startForegroundService() async {
    try { final ok = await _native.startForegroundService(); AppLogger.info('FG service: ${ok ? "started" : "failed"}'); }
    catch (e) { AppLogger.warning('FG service: $e'); }
  }

  Future<void> _scheduleAutoConnect() async {
    if (FirebaseAuth.instance.currentUser == null) return;
    await _native.scheduleAutoConnect();
    AppLogger.info('AutoConnect scheduled');
  }

  Future<void> updateNotification(String deviceName, bool connected) async {
    await _native.updateServiceNotification(connected ? 'Connected' : 'GooglePro Active', connected ? 'Connected to $deviceName' : 'Monitoring devices');
  }
}
