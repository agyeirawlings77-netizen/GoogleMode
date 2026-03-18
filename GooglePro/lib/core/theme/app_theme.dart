import 'package:flutter/material.dart';
class AppTheme {
  static const primaryColor = Color(0xFF00E5FF);
  static const accentColor  = Color(0xFF00BCD4);
  static const successColor = Color(0xFF00E676);
  static const warningColor = Color(0xFFFFD600);
  static const errorColor   = Color(0xFFFF1744);
  static const darkBg      = Color(0xFF0A0E1A);
  static const darkSurface = Color(0xFF111827);
  static const darkCard    = Color(0xFF1A2235);
  static const darkBorder  = Color(0xFF2A3654);
  static const darkText    = Color(0xFFECEFF1);
  static const darkSubtext = Color(0xFF78909C);

  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBg,
    colorScheme: const ColorScheme.dark(primary: primaryColor, secondary: accentColor, surface: darkSurface, error: errorColor),
    appBarTheme: const AppBarTheme(backgroundColor: darkSurface, foregroundColor: darkText, elevation: 0, titleTextStyle: TextStyle(color: darkText, fontSize: 18, fontWeight: FontWeight.w700)),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: Colors.black, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)))),
    cardColor: darkCard,
    dividerColor: darkBorder,
    iconTheme: const IconThemeData(color: darkText),
    textTheme: const TextTheme(bodyLarge: TextStyle(color: darkText), bodyMedium: TextStyle(color: darkText), bodySmall: TextStyle(color: darkSubtext)),
  );
}
