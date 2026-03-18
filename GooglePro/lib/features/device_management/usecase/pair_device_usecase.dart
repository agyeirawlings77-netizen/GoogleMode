import 'package:injectable/injectable.dart';
import '../model/qr_pair_model.dart';
import '../repository/device_repository.dart';
import '../../trusted_device/model/trusted_device_model.dart';
import '../../trusted_device/repository/trusted_device_repository.dart';

@injectable
class PairDeviceUsecase {
  final DeviceRepository _deviceRepo;
  final TrustedDeviceRepository _trustedRepo;
  PairDeviceUsecase(this._deviceRepo, this._trustedRepo);

  Future<void> call(QrPairModel qr) async {
    if (qr.isExpired) throw Exception('QR code expired');
    await _trustedRepo.save(TrustedDeviceModel(deviceId: qr.deviceId, deviceName: qr.deviceName, deviceType: qr.deviceType, ownerUserId: qr.ownerUserId, fcmToken: qr.fcmToken, savedAt: DateTime.now(), lastConnectedAt: DateTime.now()));
  }
}
