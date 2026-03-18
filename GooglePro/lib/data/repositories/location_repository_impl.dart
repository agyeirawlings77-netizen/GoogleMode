import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../datasources/remote/location_remote_datasource.dart';
import '../models/location_model.dart';
import '../../features/location/service/location_service.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/i_location_repository.dart';

@LazySingleton(as: ILocationRepository)
class LocationRepositoryImpl implements ILocationRepository {
  final LocationService _svc;
  final LocationRemoteDatasource _remote;
  LocationRepositoryImpl(this._svc, this._remote);
  @override Future<Either<String, LocationEntity>> getCurrentLocation() async { try { final p = await _svc.getCurrentLocation(); if (p == null) return const Left('Location unavailable'); return Right(p); } catch (e) { return Left(e.toString()); } }
  @override Stream<LocationEntity> watchLocation() => _svc.locationStream;
  @override Future<Either<String, void>> shareLocation(String uid, LocationEntity loc) async { try { await _remote.publish(uid, loc); return const Right(null); } catch (e) { return Left(e.toString()); } }
  @override Stream<LocationEntity?> watchDeviceLocation(String uid) => _remote.watch(uid);
  @override Future<Either<String, void>> stopSharing(String uid) async { try { await _remote.remove(uid); return const Right(null); } catch (e) { return Left(e.toString()); } }
  @override Future<bool> requestPermission() => _svc.requestPermission();
}
