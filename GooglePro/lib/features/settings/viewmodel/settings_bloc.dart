import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/settings_repository.dart';
import '../model/app_settings.dart';
import '../state/settings_state.dart';
import '../state/settings_event.dart';
import '../../../core/utils/app_logger.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _repo;
  SettingsBloc(this._repo) : super(const SettingsInitial()) {
    on<LoadSettingsEvent>(_onLoad);
    on<UpdateSettingsEvent>(_onUpdate);
    on<ResetSettingsEvent>(_onReset);
    on<ChangeLanguageEvent>(_onChangeLanguage);
    on<ToggleNotificationsEvent>(_onToggleNotif);
    on<ToggleAutoConnectEvent>(_onToggleAutoConnect);
  }

  void _onLoad(LoadSettingsEvent e, Emitter<SettingsState> emit) {
    emit(const SettingsLoading());
    try {
      final settings = _repo.getSettings();
      emit(SettingsLoaded(settings));
    } catch (err) { emit(SettingsError(err.toString())); }
  }

  Future<void> _onUpdate(UpdateSettingsEvent e, Emitter<SettingsState> emit) async {
    try {
      await _repo.saveSettings(e.settings);
      emit(SettingsLoaded(e.settings));
      AppLogger.info('Settings saved');
    } catch (err) { emit(SettingsError(err.toString())); }
  }

  Future<void> _onReset(ResetSettingsEvent e, Emitter<SettingsState> emit) async {
    await _repo.resetSettings();
    emit(const SettingsLoaded(AppSettings()));
  }

  Future<void> _onChangeLanguage(ChangeLanguageEvent e, Emitter<SettingsState> emit) async {
    if (state is SettingsLoaded) {
      final updated = (state as SettingsLoaded).settings.copyWith(language: e.languageCode);
      add(UpdateSettingsEvent(updated));
    }
  }

  Future<void> _onToggleNotif(ToggleNotificationsEvent e, Emitter<SettingsState> emit) async {
    if (state is SettingsLoaded) {
      final updated = (state as SettingsLoaded).settings.copyWith(notificationsEnabled: e.enabled);
      add(UpdateSettingsEvent(updated));
    }
  }

  Future<void> _onToggleAutoConnect(ToggleAutoConnectEvent e, Emitter<SettingsState> emit) async {
    if (state is SettingsLoaded) {
      final updated = (state as SettingsLoaded).settings.copyWith(autoConnectEnabled: e.enabled);
      add(UpdateSettingsEvent(updated));
    }
  }
}
