import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import 'trusted_device_manager.dart';
import '../model/trusted_device.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class AutoConnectService {
  final TrustedDeviceManager _trustedManager;
  final _db = FirebaseDatabase.instance;
  Timer? _watchTimer;
  final _autoConnectCtrl = StreamController<TrustedDevice>.broadcast();

  Stream<TrustedDevice> get onAutoConnectTriggered => _autoConnectCtrl.stream;

  AutoConnectService(this._trustedManager);

  String get _myUid => FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<void> startWatching() async {
    final trustedDevices = await _trustedManager.getTrustedDevices();
    if (trustedDevices.isEmpty) return;

    AppLogger.info('AutoConnect: watching ${trustedDevices.length} trusted devices');

    for (final device in trustedDevices) {
      if (!device.autoConnect) continue;
      _db.ref('${AppConstants.presencePath}/${device.ownerUid}/${device.deviceId}/online').onValue.listen((event) {
        final isOnline = event.snapshot.value as bool? ?? false;
        if (isOnline) {
          AppLogger.info('AutoConnect: ${device.deviceName} came online!');
          _autoConnectCtrl.add(device);
        }
      });
    }
  }

  Future<void> triggerAutoConnect(String targetUid, String deviceId) async {
    await _db.ref('${AppConstants.autoConnectSignalsPath}/$targetUid/$deviceId').set({'from': _myUid, 'action': 'connect', 'ts': ServerValue.timestamp});
    AppLogger.info('AutoConnect signal sent → $targetUid/$deviceId');
  }

  Stream<Map<String, dynamic>?> watchForAutoConnectSignals() {
    return _db.ref('${AppConstants.autoConnectSignalsPath}/$_myUid').onValue.map((event) {
      if (!event.snapshot.exists) return null;
      return Map<String, dynamic>.from(event.snapshot.value as Map);
    });
  }

  Future<void> clearAutoConnectSignal(String deviceId) =>
    _db.ref('${AppConstants.autoConnectSignalsPath}/$_myUid/$deviceId').remove();

  void stopWatching() {
    _watchTimer?.cancel();
    AppLogger.info('AutoConnect: stopped watching');
  }

  void dispose() {
    stopWatching();
    _autoConnectCtrl.close();
  }
}
