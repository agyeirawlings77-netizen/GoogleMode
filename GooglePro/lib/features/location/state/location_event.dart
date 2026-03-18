import 'package:equatable/equatable.dart';
abstract class LocationEvent extends Equatable {
  const LocationEvent();
  @override List<Object?> get props => [];
}
class LoadLocationEvent extends LocationEvent {
  final String deviceUid;
  const LoadLocationEvent(this.deviceUid);
  @override List<Object?> get props => [deviceUid];
}
class StartSharingEvent extends LocationEvent { const StartSharingEvent(); }
class StopSharingEvent extends LocationEvent { const StopSharingEvent(); }
class RefreshLocationEvent extends LocationEvent { const RefreshLocationEvent(); }
