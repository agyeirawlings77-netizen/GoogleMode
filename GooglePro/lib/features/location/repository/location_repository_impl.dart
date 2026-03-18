import 'package:injectable/injectable.dart';
import '../service/location_service.dart';
import '../model/location_point.dart';
import 'location_repository.dart';
@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  final LocationService _svc;
  LocationRepositoryImpl(this._svc);
  @override Future<LocationPoint?> getCurrentLocation() => _svc.getCurrentLocation();
  @override Stream<LocationPoint> watchLocation() => _svc.locationStream;
  @override Future<void> shareLocation(String uid, LocationPoint pt) => _svc.startSharing();
  @override Stream<LocationPoint?> watchDeviceLocation(String uid) => _svc.watchDeviceLocation(uid);
  @override Future<void> stopSharing(String uid) => _svc.stopSharing();
}
