import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class LocaleProvider extends ChangeNotifier {
  final SharedPreferences _prefs;
  static const _key = 'app_locale';
  Locale _locale = const Locale('en');

  LocaleProvider(this._prefs) {
    _loadLocale();
  }

  Locale get locale => _locale;

  void _loadLocale() {
    final code = _prefs.getString(_key) ?? 'en';
    _locale = Locale(code);
  }

  Future<void> setLocale(String languageCode) async {
    _locale = Locale(languageCode);
    await _prefs.setString(_key, languageCode);
    notifyListeners();
  }

  static const supportedLocales = [
    Locale('en'), Locale('fr'), Locale('es'), Locale('ar'),
    Locale('pt'), Locale('hi'), Locale('yo'), Locale('zh'),
    Locale('de'), Locale('ja'),
  ];
}
