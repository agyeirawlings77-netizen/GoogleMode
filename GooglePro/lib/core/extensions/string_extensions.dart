extension StringExtensions on String {
  String get capitalize => isEmpty ? this : '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  String get titleCase => split(' ').map((w) => w.capitalize).join(' ');
  bool get isEmail => RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(this);
  bool get isPhone => RegExp(r'^\+?[0-9]{10,15}$').hasMatch(replaceAll(RegExp(r'[\s\-\(\)]'), ''));
  bool get isUrl => RegExp(r'https?://[^\s]+').hasMatch(this);
  String get initials { final parts = trim().split(' ').where((p) => p.isNotEmpty).toList(); if (parts.isEmpty) return '?'; if (parts.length == 1) return parts[0][0].toUpperCase(); return '${parts[0][0]}${parts.last[0]}'.toUpperCase(); }
  String truncate(int max) => length <= max ? this : '${substring(0, max)}...';
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');
  bool get isNullOrEmpty => isEmpty;
  String orDefault(String defaultVal) => isEmpty ? defaultVal : this;
}
