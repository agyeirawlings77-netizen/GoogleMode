import 'package:equatable/equatable.dart';
abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
  @override List<Object?> get props => [];
}
class LoadDashboardEvent extends DashboardEvent { const LoadDashboardEvent(); }
class RefreshDashboardEvent extends DashboardEvent { const RefreshDashboardEvent(); }
class DeviceStatusChangedEvent extends DashboardEvent {
  final String deviceId;
  final bool isOnline;
  const DeviceStatusChangedEvent({required this.deviceId, required this.isOnline});
  @override List<Object?> get props => [deviceId, isOnline];
}
