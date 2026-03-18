import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import '../model/pairing_data.dart';
import '../../device_management/model/device_model_local.dart';
import '../../device_management/service/device_service.dart';
import '../../auto_connect/service/trusted_device_manager.dart';
import '../../auto_connect/model/trusted_device.dart';
import '../../../core/utils/app_logger.dart';

@injectable
class QrPairingService {
  final DeviceService _deviceSvc;
  final TrustedDeviceManager _trustedMgr;
  QrPairingService(this._deviceSvc, this._trustedMgr);

  PairingData generatePairingData() {
    final user = FirebaseAuth.instance.currentUser;
    return PairingData(deviceId: const Uuid().v4(), deviceName: 'My Device', ownerUid: user?.uid ?? '', timestamp: DateTime.now().millisecondsSinceEpoch);
  }

  Future<DeviceModelLocal> completePairing(PairingData data) async {
    if (data.isExpired) throw Exception('QR code expired. Please generate a new one.');
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    final device = DeviceModelLocal(deviceId: data.deviceId, deviceName: data.deviceName, ownerUserId: data.ownerUid, fcmToken: data.fcmToken, isTrusted: true);
    await _deviceSvc.renameDevice(device.deviceId, device.deviceName).catchError((_) {});
    final trusted = TrustedDevice(deviceId: data.deviceId, deviceName: data.deviceName, ownerUid: data.ownerUid, pairedAt: DateTime.now(), fcmToken: data.fcmToken);
    await _trustedMgr.saveTrustedDevice(trusted);
    AppLogger.info('Pairing complete: ${data.deviceName}');
    return device;
  }
}
