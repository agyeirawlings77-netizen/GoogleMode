import 'package:injectable/injectable.dart';
import '../repository/trusted_device_repository.dart';

@injectable
class CheckAutoConnectUsecase {
  final TrustedDeviceRepository _repo;
  CheckAutoConnectUsecase(this._repo);

  Future<List<String>> getOnlineTrustedDeviceIds(String ownerUserId) async {
    final devices = await _repo.getAll();
    final online = <String>[];
    for (final device in devices.where((d) => d.autoConnect)) {
      _repo.watchOnlineStatus(ownerUserId, device.deviceId).take(1).listen((isOnline) { if (isOnline) online.add(device.deviceId); });
    }
    await Future.delayed(const Duration(seconds: 2));
    return online;
  }
}
