import 'package:flutter/material.dart';

enum ThemeMode2 { system, light, dark }
enum AccentColor { cyan, green, purple, orange, red, pink }

class AppThemeModel {
  final ThemeMode2 mode;
  final AccentColor accent;
  final bool trueBlack;
  final double borderRadius;
  const AppThemeModel({this.mode = ThemeMode2.dark, this.accent = AccentColor.cyan, this.trueBlack = false, this.borderRadius = 16.0});
  AppThemeModel copyWith({ThemeMode2? mode, AccentColor? accent, bool? trueBlack, double? borderRadius}) =>
    AppThemeModel(mode: mode ?? this.mode, accent: accent ?? this.accent, trueBlack: trueBlack ?? this.trueBlack, borderRadius: borderRadius ?? this.borderRadius);
  factory AppThemeModel.fromJson(Map<String, dynamic> j) => AppThemeModel(mode: ThemeMode2.values.firstWhere((m) => m.name == j['mode'], orElse: () => ThemeMode2.dark), accent: AccentColor.values.firstWhere((a) => a.name == j['accent'], orElse: () => AccentColor.cyan), trueBlack: j['trueBlack'] ?? false, borderRadius: (j['borderRadius'] ?? 16.0).toDouble());
  Map<String, dynamic> toJson() => {'mode': mode.name, 'accent': accent.name, 'trueBlack': trueBlack, 'borderRadius': borderRadius};
}
