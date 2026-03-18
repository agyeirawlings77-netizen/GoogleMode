import 'package:injectable/injectable.dart';
import '../model/trusted_device_model.dart';
import '../repository/trusted_device_repository.dart';

@injectable
class SaveTrustedDeviceUsecase {
  final TrustedDeviceRepository _repo;
  SaveTrustedDeviceUsecase(this._repo);
  Future<void> call(TrustedDeviceModel device) => _repo.save(device);
}
