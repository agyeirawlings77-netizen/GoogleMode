import 'package:equatable/equatable.dart';
import '../model/location_point.dart';
abstract class LocationState extends Equatable {
  const LocationState();
  @override List<Object?> get props => [];
}
class LocationInitial extends LocationState { const LocationInitial(); }
class LocationLoading extends LocationState { const LocationLoading(); }
class LocationLoaded extends LocationState {
  final LocationPoint? myLocation;
  final LocationPoint? deviceLocation;
  final bool isSharing;
  const LocationLoaded({this.myLocation, this.deviceLocation, this.isSharing = false});
  @override List<Object?> get props => [myLocation, deviceLocation, isSharing];
  LocationLoaded copyWith({LocationPoint? myLocation, LocationPoint? deviceLocation, bool? isSharing}) =>
    LocationLoaded(myLocation: myLocation ?? this.myLocation, deviceLocation: deviceLocation ?? this.deviceLocation, isSharing: isSharing ?? this.isSharing);
}
class LocationError extends LocationState {
  final String message;
  const LocationError(this.message);
  @override List<Object?> get props => [message];
}
