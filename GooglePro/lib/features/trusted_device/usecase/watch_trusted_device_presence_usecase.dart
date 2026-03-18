import 'package:injectable/injectable.dart';
import '../repository/trusted_device_repository.dart';

@injectable
class WatchTrustedDevicePresenceUsecase {
  final TrustedDeviceRepository _repo;
  WatchTrustedDevicePresenceUsecase(this._repo);
  Stream<bool> call(String ownerUserId, String deviceId) => _repo.watchOnlineStatus(ownerUserId, deviceId);
}
