import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import '../model/location_point.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class LocationService {
  final _db = FirebaseDatabase.instance;
  StreamSubscription<Position>? _positionSub;
  bool _sharing = false;
  final _locationCtrl = StreamController<LocationPoint>.broadcast();

  Stream<LocationPoint> get locationStream => _locationCtrl.stream;
  bool get isSharing => _sharing;
  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<bool> requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) permission = await Geolocator.requestPermission();
    return permission != LocationPermission.denied && permission != LocationPermission.deniedForever;
  }

  Future<LocationPoint?> getCurrentLocation() async {
    try {
      final hasPermission = await requestPermission();
      if (!hasPermission) return null;
      final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high, timeLimit: const Duration(seconds: 10));
      return LocationPoint(latitude: pos.latitude, longitude: pos.longitude, accuracy: pos.accuracy, altitude: pos.altitude, speed: pos.speed, heading: pos.heading, timestamp: DateTime.now());
    } catch (e) { AppLogger.error('Get location failed', e); return null; }
  }

  Future<void> startSharing() async {
    if (_sharing) return;
    final hasPermission = await requestPermission();
    if (!hasPermission) throw Exception('Location permission denied');
    _sharing = true;
    _positionSub = Geolocator.getPositionStream(locationSettings: const LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10)).listen((pos) async {
      final point = LocationPoint(latitude: pos.latitude, longitude: pos.longitude, accuracy: pos.accuracy, altitude: pos.altitude, speed: pos.speed, heading: pos.heading, timestamp: DateTime.now());
      _locationCtrl.add(point);
      await _publishLocation(point);
    });
    AppLogger.info('Location sharing started');
  }

  Future<void> stopSharing() async {
    await _positionSub?.cancel();
    _positionSub = null;
    _sharing = false;
    await _db.ref('presence/$_uid/location').remove();
    AppLogger.info('Location sharing stopped');
  }

  Future<void> _publishLocation(LocationPoint loc) => _db.ref('presence/$_uid/location').set(loc.toJson());

  Stream<LocationPoint?> watchDeviceLocation(String uid) => _db.ref('presence/$uid/location').onValue.map((e) {
    if (!e.snapshot.exists) return null;
    return LocationPoint.fromJson(Map<String, dynamic>.from(e.snapshot.value as Map));
  });

  void dispose() { stopSharing(); _locationCtrl.close(); }
}
