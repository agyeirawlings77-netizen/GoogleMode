import 'package:equatable/equatable.dart';
import '../model/app_settings.dart';
abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
  @override List<Object?> get props => [];
}
class LoadSettingsEvent extends SettingsEvent { const LoadSettingsEvent(); }
class UpdateSettingsEvent extends SettingsEvent {
  final AppSettings settings;
  const UpdateSettingsEvent(this.settings);
  @override List<Object?> get props => [settings];
}
class ResetSettingsEvent extends SettingsEvent { const ResetSettingsEvent(); }
class ChangeLanguageEvent extends SettingsEvent {
  final String languageCode;
  const ChangeLanguageEvent(this.languageCode);
  @override List<Object?> get props => [languageCode];
}
class ToggleNotificationsEvent extends SettingsEvent {
  final bool enabled;
  const ToggleNotificationsEvent(this.enabled);
  @override List<Object?> get props => [enabled];
}
class ToggleAutoConnectEvent extends SettingsEvent {
  final bool enabled;
  const ToggleAutoConnectEvent(this.enabled);
  @override List<Object?> get props => [enabled];
}
