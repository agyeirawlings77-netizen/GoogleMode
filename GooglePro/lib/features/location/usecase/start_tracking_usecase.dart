import 'package:injectable/injectable.dart';
import '../service/location_service.dart';
import '../model/location_point.dart';
@injectable
class StartTrackingUsecase {
  final LocationService _svc;
  StartTrackingUsecase(this._svc);
  void call(void Function(LocationPoint) onLocation) => _svc.startTracking(onLocation);
}
