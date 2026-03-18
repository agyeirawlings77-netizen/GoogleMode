import 'package:equatable/equatable.dart';
abstract class SecurityEvent extends Equatable {
  const SecurityEvent();
  @override List<Object?> get props => [];
}
class LoadSecurityDataEvent extends SecurityEvent { const LoadSecurityDataEvent(); }
class UpdateSettingsEvent extends SecurityEvent {
  final Map<String, dynamic> changes;
  const UpdateSettingsEvent(this.changes);
  @override List<Object?> get props => [changes];
}
class RunSecurityScanEvent extends SecurityEvent { const RunSecurityScanEvent(); }
class MarkAlertReadEvent extends SecurityEvent {
  final String alertId;
  const MarkAlertReadEvent(this.alertId);
  @override List<Object?> get props => [alertId];
}
