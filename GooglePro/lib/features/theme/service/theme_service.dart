import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/app_theme_model.dart';

@singleton
class ThemeService {
  final SharedPreferences _prefs;
  static const _key = 'app_theme_v1';
  ThemeService(this._prefs);

  AppThemeModel load() {
    final raw = _prefs.getString(_key);
    if (raw == null) return const AppThemeModel();
    try { return AppThemeModel.fromJson(jsonDecode(raw)); }
    catch (_) { return const AppThemeModel(); }
  }

  Future<void> save(AppThemeModel m) => _prefs.setString(_key, jsonEncode(m.toJson()));

  ThemeMode toFlutterThemeMode(ThemeMode2 m) { switch (m) { case ThemeMode2.light: return ThemeMode.light; case ThemeMode2.dark: return ThemeMode.dark; case ThemeMode2.system: return ThemeMode.system; } }

  Color accentToColor(AccentColor a) { switch (a) { case AccentColor.cyan: return const Color(0xFF00C2FF); case AccentColor.green: return const Color(0xFF00FF94); case AccentColor.purple: return const Color(0xFF7C4DFF); case AccentColor.orange: return const Color(0xFFFF6D00); case AccentColor.red: return const Color(0xFFFF4D4D); case AccentColor.pink: return const Color(0xFFFF4081); } }
}
