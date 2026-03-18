import 'package:flutter/material.dart';
class ColorUtils {
  static Color fromHex(String hex) { final h = hex.replaceAll('#', ''); return Color(int.parse(h.length == 6 ? 'FF$h' : h, radix: 16)); }
  static String toHex(Color c) => '#${c.value.toRadixString(16).substring(2).toUpperCase()}';
  static bool isDark(Color c) => c.computeLuminance() < 0.5;
  static Color textOn(Color bg) => isDark(bg) ? Colors.white : Colors.black;
}
