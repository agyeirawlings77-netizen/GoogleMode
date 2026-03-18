import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import '../../../core/constants/app_constants.dart';
import '../model/trusted_device_presence.dart';

@singleton
class TrustedDeviceRemoteDatasource {
  Future<TrustedDevicePresence?> getPresence(String ownerUserId, String deviceId) async {
    try {
      final snap = await FirebaseDatabase.instance.ref('${AppConstants.presencePath}/$ownerUserId/$deviceId').get();
      if (!snap.exists) return null;
      return TrustedDevicePresence.fromMap(deviceId, snap.value as Map<dynamic, dynamic>);
    } catch (_) { return null; }
  }

  Stream<TrustedDevicePresence> watchPresence(String ownerUserId, String deviceId) =>
    FirebaseDatabase.instance.ref('${AppConstants.presencePath}/$ownerUserId/$deviceId').onValue
      .map((e) => e.snapshot.exists ? TrustedDevicePresence.fromMap(deviceId, e.snapshot.value as Map<dynamic, dynamic>) : TrustedDevicePresence(deviceId: deviceId, online: false));
}
