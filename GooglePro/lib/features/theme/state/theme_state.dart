import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../model/app_theme_model.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
  @override List<Object?> get props => [];
}
class ThemeLoaded extends ThemeState {
  final AppThemeModel themeModel;
  final ThemeMode flutterThemeMode;
  const ThemeLoaded({required this.themeModel, required this.flutterThemeMode});
  @override List<Object?> get props => [themeModel];
}
