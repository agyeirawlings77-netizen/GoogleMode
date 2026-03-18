import 'package:equatable/equatable.dart';
import '../model/app_settings.dart';
abstract class SettingsState extends Equatable {
  const SettingsState();
  @override List<Object?> get props => [];
}
class SettingsInitial extends SettingsState { const SettingsInitial(); }
class SettingsLoading extends SettingsState { const SettingsLoading(); }
class SettingsLoaded extends SettingsState {
  final AppSettings settings;
  const SettingsLoaded(this.settings);
  @override List<Object?> get props => [settings];
  SettingsLoaded copyWith({AppSettings? settings}) => SettingsLoaded(settings ?? this.settings);
}
class SettingsError extends SettingsState {
  final String message;
  const SettingsError(this.message);
  @override List<Object?> get props => [message];
}
class SettingsSaved extends SettingsState { const SettingsSaved(); }
