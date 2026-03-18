import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/theme_service.dart';
import '../model/app_theme_model.dart';
import '../state/theme_state.dart';
import '../state/theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeService _svc;
  ThemeBloc(this._svc) : super(ThemeLoaded(themeModel: const AppThemeModel(), flutterThemeMode: ThemeMode.dark)) {
    on<LoadThemeEvent>(_onLoad);
    on<ChangeThemeModeEvent>(_onChange);
    on<ChangeAccentColorEvent>(_onAccent);
    on<ToggleTrueBlackEvent>(_onTrueBlack);
  }

  void _onLoad(LoadThemeEvent e, Emitter<ThemeState> emit) {
    final m = _svc.load();
    emit(ThemeLoaded(themeModel: m, flutterThemeMode: _svc.toFlutterThemeMode(m.mode)));
  }

  Future<void> _onChange(ChangeThemeModeEvent e, Emitter<ThemeState> emit) async {
    final current = (state as ThemeLoaded).themeModel;
    final updated = current.copyWith(mode: e.mode);
    await _svc.save(updated);
    emit(ThemeLoaded(themeModel: updated, flutterThemeMode: _svc.toFlutterThemeMode(e.mode)));
  }

  Future<void> _onAccent(ChangeAccentColorEvent e, Emitter<ThemeState> emit) async {
    final current = (state as ThemeLoaded).themeModel;
    final updated = current.copyWith(accent: e.accent);
    await _svc.save(updated);
    emit(ThemeLoaded(themeModel: updated, flutterThemeMode: _svc.toFlutterThemeMode(current.mode)));
  }

  Future<void> _onTrueBlack(ToggleTrueBlackEvent e, Emitter<ThemeState> emit) async {
    final current = (state as ThemeLoaded).themeModel;
    final updated = current.copyWith(trueBlack: e.enabled);
    await _svc.save(updated);
    emit(ThemeLoaded(themeModel: updated, flutterThemeMode: _svc.toFlutterThemeMode(current.mode)));
  }
}
