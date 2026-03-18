import 'package:dartz/dartz.dart';
import '../entities/location_entity.dart';

abstract class ILocationRepository {
  Future<Either<String, LocationEntity>> getCurrentLocation();
  Stream<LocationEntity> watchLocation();
  Future<Either<String, void>> shareLocation(String uid, LocationEntity location);
  Stream<LocationEntity?> watchDeviceLocation(String uid);
  Future<Either<String, void>> stopSharing(String uid);
  Future<bool> requestPermission();
}
