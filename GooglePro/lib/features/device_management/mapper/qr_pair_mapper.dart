import '../model/qr_pair_model.dart';
import '../../trusted_device/model/trusted_device_model.dart';
class QrPairMapper {
  static TrustedDeviceModel toTrustedDevice(QrPairModel qr) => TrustedDeviceModel(deviceId: qr.deviceId, deviceName: qr.deviceName, deviceType: qr.deviceType, ownerUserId: qr.ownerUserId, fcmToken: qr.fcmToken, savedAt: DateTime.now(), lastConnectedAt: DateTime.now(), autoConnect: true);
}
