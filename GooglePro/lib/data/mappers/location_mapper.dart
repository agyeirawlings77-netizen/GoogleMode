import '../models/location_model.dart';
import '../../domain/entities/location_entity.dart';

class LocationMapper {
  static LocationModel fromJson(Map<String, dynamic> j) => LocationModel.fromJson(j);
  static Map<String, dynamic> toFirebase(LocationEntity e) => LocationModel(latitude: e.latitude, longitude: e.longitude, accuracy: e.accuracy, altitude: e.altitude, speed: e.speed, timestamp: e.timestamp).toJson();
}
