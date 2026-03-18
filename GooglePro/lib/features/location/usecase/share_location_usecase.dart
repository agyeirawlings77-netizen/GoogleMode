import 'package:injectable/injectable.dart';
import '../service/location_service.dart';
@injectable
class ShareLocationUsecase {
  final LocationService _svc;
  ShareLocationUsecase(this._svc);
  Future<void> start() => _svc.startSharing();
  Future<void> stop() => _svc.stopSharing();
}
