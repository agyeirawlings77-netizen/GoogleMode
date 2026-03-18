import 'package:equatable/equatable.dart';
import '../model/app_theme_model.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
  @override List<Object?> get props => [];
}
class LoadThemeEvent extends ThemeEvent { const LoadThemeEvent(); }
class ChangeThemeModeEvent extends ThemeEvent {
  final ThemeMode2 mode;
  const ChangeThemeModeEvent(this.mode);
  @override List<Object?> get props => [mode];
}
class ChangeAccentColorEvent extends ThemeEvent {
  final AccentColor accent;
  const ChangeAccentColorEvent(this.accent);
  @override List<Object?> get props => [accent];
}
class ToggleTrueBlackEvent extends ThemeEvent {
  final bool enabled;
  const ToggleTrueBlackEvent(this.enabled);
  @override List<Object?> get props => [enabled];
}
