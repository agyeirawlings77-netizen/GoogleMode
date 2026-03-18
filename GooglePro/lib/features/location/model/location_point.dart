class LocationPoint {
  final double latitude;
  final double longitude;
  final double? accuracy;
  final double? altitude;
  final double? speed;
  final double? heading;
  final DateTime timestamp;
  final String? address;
  const LocationPoint({required this.latitude, required this.longitude, this.accuracy, this.altitude, this.speed, this.heading, required this.timestamp, this.address});
  String get formatted => '${latitude.toStringAsFixed(5)}, ${longitude.toStringAsFixed(5)}';
  factory LocationPoint.fromJson(Map<String, dynamic> j) => LocationPoint(latitude: (j['latitude'] as num).toDouble(), longitude: (j['longitude'] as num).toDouble(), accuracy: (j['accuracy'] as num?)?.toDouble(), altitude: (j['altitude'] as num?)?.toDouble(), speed: (j['speed'] as num?)?.toDouble(), heading: (j['heading'] as num?)?.toDouble(), timestamp: j['timestamp'] != null ? DateTime.fromMillisecondsSinceEpoch(j['timestamp'] as int) : DateTime.now(), address: j['address'] as String?);
  Map<String, dynamic> toJson() => {'latitude': latitude, 'longitude': longitude, 'accuracy': accuracy, 'altitude': altitude, 'speed': speed, 'heading': heading, 'timestamp': timestamp.millisecondsSinceEpoch, 'address': address};
}
