import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import '../model/location_point.dart';
@singleton
class LocationRemoteDatasource {
  final _db = FirebaseDatabase.instance;
  Future<void> publishLocation(String uid, LocationPoint pt) => _db.ref('presence/$uid/location').set(pt.toJson());
  Future<void> removeLocation(String uid) => _db.ref('presence/$uid/location').remove();
  Stream<LocationPoint?> watchLocation(String uid) => _db.ref('presence/$uid/location').onValue.map((e) {
    if (!e.snapshot.exists) return null;
    return LocationPoint.fromJson(Map<String, dynamic>.from(e.snapshot.value as Map));
  });
}
