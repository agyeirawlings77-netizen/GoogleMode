import '../model/location_point.dart';
abstract class LocationRepository {
  Future<LocationPoint?> getCurrentLocation();
  Stream<LocationPoint> watchLocation();
  Future<void> shareLocation(String uid, LocationPoint point);
  Stream<LocationPoint?> watchDeviceLocation(String uid);
  Future<void> stopSharing(String uid);
}
