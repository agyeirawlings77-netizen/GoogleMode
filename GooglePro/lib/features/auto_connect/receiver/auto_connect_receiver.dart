import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import '../service/trusted_device_manager.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class AutoConnectReceiver {
  final TrustedDeviceManager _trustedManager;
  final _db = FirebaseDatabase.instance;
  StreamSubscription? _sub;
  final _triggerCtrl = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get onTrigger => _triggerCtrl.stream;
  AutoConnectReceiver(this._trustedManager);

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<void> startListening() async {
    _sub = _db.ref('${AppConstants.autoConnectSignalsPath}/$_uid').onValue.listen((event) {
      if (!event.snapshot.exists) return;
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      for (final entry in data.entries) {
        final signal = Map<String, dynamic>.from(entry.value as Map);
        final fromUid = signal['from'] as String?;
        final action = signal['action'] as String?;
        if (fromUid != null && action == 'connect') {
          AppLogger.info('AutoConnect signal from $fromUid');
          _triggerCtrl.add({'fromUid': fromUid, 'deviceId': entry.key, ...signal});
          _db.ref('${AppConstants.autoConnectSignalsPath}/$_uid/${entry.key}').remove();
        }
      }
    });
    AppLogger.info('AutoConnect receiver started for $_uid');
  }

  Future<void> stopListening() async {
    await _sub?.cancel();
    AppLogger.info('AutoConnect receiver stopped');
  }

  void dispose() { stopListening(); _triggerCtrl.close(); }
}
