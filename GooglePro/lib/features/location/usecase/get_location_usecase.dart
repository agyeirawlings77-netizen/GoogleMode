import 'package:injectable/injectable.dart';
import '../service/location_service.dart';
import '../model/location_point.dart';
@injectable
class GetLocationUsecase {
  final LocationService _svc;
  GetLocationUsecase(this._svc);
  Future<LocationPoint?> call() => _svc.getCurrentLocation();
}
