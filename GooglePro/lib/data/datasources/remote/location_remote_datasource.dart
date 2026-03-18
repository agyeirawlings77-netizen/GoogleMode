import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import '../../models/location_model.dart';
import '../../../domain/entities/location_entity.dart';

@singleton
class LocationRemoteDatasource {
  final FirebaseDatabase _rtdb;
  LocationRemoteDatasource(this._rtdb);

  Future<void> publish(String uid, LocationEntity loc) => _rtdb.ref('presence/$uid/location').set(LocationModel.fromJson(loc.toJson()).toJson());
  Future<void> remove(String uid) => _rtdb.ref('presence/$uid/location').remove();
  Stream<LocationModel?> watch(String uid) => _rtdb.ref('presence/$uid/location').onValue.map((e) {
    if (!e.snapshot.exists) return null;
    return LocationModel.fromJson(Map<String, dynamic>.from(e.snapshot.value as Map));
  });
}

extension on LocationEntity {
  Map<String, dynamic> toJson() => {'latitude': latitude, 'longitude': longitude, 'accuracy': accuracy, 'altitude': altitude, 'speed': speed, 'timestamp': timestamp.millisecondsSinceEpoch};
}
