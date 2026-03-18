import 'package:equatable/equatable.dart';
import '../../device_management/model/device_model_local.dart';
import '../model/dashboard_stats.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
  @override List<Object?> get props => [];
}
class DashboardInitial extends DashboardState { const DashboardInitial(); }
class DashboardLoading extends DashboardState { const DashboardLoading(); }
class DashboardLoaded extends DashboardState {
  final List<DeviceModelLocal> devices;
  final DashboardStats stats;
  const DashboardLoaded({required this.devices, required this.stats});
  @override List<Object?> get props => [devices, stats];
  int get onlineCount => devices.where((d) => d.isOnline).length;
}
class DashboardError extends DashboardState {
  final String message;
  const DashboardError(this.message);
  @override List<Object?> get props => [message];
}
