import 'package:injectable/injectable.dart';
import '../model/trusted_device_model.dart';
import '../repository/trusted_device_repository.dart';

@injectable
class GetTrustedDevicesUsecase {
  final TrustedDeviceRepository _repo;
  GetTrustedDevicesUsecase(this._repo);
  Future<List<TrustedDeviceModel>> call() => _repo.getAll();
}
