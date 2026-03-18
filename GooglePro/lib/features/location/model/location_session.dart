import 'location_point.dart';
class LocationSession {
  final String sessionId;
  final String deviceId;
  final String deviceName;
  final List<LocationPoint> history;
  LocationPoint? current;
  final bool isSharing;
  final bool isTracking;
  const LocationSession({required this.sessionId, required this.deviceId, required this.deviceName, this.history = const [], this.current, this.isSharing = false, this.isTracking = false});
  LocationSession copyWith({LocationPoint? current, bool? isSharing, bool? isTracking, List<LocationPoint>? history}) =>
    LocationSession(sessionId: sessionId, deviceId: deviceId, deviceName: deviceName, history: history ?? this.history, current: current ?? this.current, isSharing: isSharing ?? this.isSharing, isTracking: isTracking ?? this.isTracking);
}
