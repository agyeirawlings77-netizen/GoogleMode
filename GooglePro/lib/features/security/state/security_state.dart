import 'package:equatable/equatable.dart';
import '../model/security_settings.dart';
import '../model/security_alert.dart';
abstract class SecurityState extends Equatable {
  const SecurityState();
  @override List<Object?> get props => [];
}
class SecurityInitial extends SecurityState { const SecurityInitial(); }
class SecurityLoading extends SecurityState { const SecurityLoading(); }
class SecurityLoaded extends SecurityState {
  final SecuritySettings settings;
  final List<SecurityAlert> alerts;
  final Map<String, dynamic>? scanResult;
  const SecurityLoaded({required this.settings, this.alerts = const [], this.scanResult});
  @override List<Object?> get props => [settings, alerts, scanResult];
  SecurityLoaded copyWith({SecuritySettings? settings, List<SecurityAlert>? alerts, Map<String, dynamic>? scanResult}) =>
    SecurityLoaded(settings: settings ?? this.settings, alerts: alerts ?? this.alerts, scanResult: scanResult ?? this.scanResult);
}
class SecurityError extends SecurityState {
  final String message;
  const SecurityError(this.message);
  @override List<Object?> get props => [message];
}
class SecuritySettingsSaved extends SecurityState { const SecuritySettingsSaved(); }
