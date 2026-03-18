enum GeofenceStatus { entered, exited, inside, outside }
class GeofenceModel {
  final String geofenceId;
  final String name;
  final double latitude;
  final double longitude;
  final double radiusMeters;
  GeofenceStatus status;
  final bool alertOnEnter;
  final bool alertOnExit;
  GeofenceModel({required this.geofenceId, required this.name, required this.latitude, required this.longitude, required this.radiusMeters, this.status = GeofenceStatus.outside, this.alertOnEnter = true, this.alertOnExit = true});
}
