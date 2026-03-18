import '../../domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  const LocationModel({required super.latitude, required super.longitude, super.accuracy, super.altitude, super.speed, super.heading, required super.timestamp});

  factory LocationModel.fromJson(Map<String, dynamic> j) => LocationModel(latitude: (j['latitude'] ?? 0).toDouble(), longitude: (j['longitude'] ?? 0).toDouble(), accuracy: (j['accuracy'] as num?)?.toDouble(), altitude: (j['altitude'] as num?)?.toDouble(), speed: (j['speed'] as num?)?.toDouble(), heading: (j['heading'] as num?)?.toDouble(), timestamp: j['timestamp'] != null ? DateTime.fromMillisecondsSinceEpoch(j['timestamp'] as int) : DateTime.now());

  Map<String, dynamic> toJson() => {'latitude': latitude, 'longitude': longitude, 'accuracy': accuracy, 'altitude': altitude, 'speed': speed, 'heading': heading, 'timestamp': timestamp.millisecondsSinceEpoch};
}
