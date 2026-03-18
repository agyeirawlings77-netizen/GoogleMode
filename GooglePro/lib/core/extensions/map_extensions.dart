extension MapExtensions on Map<String, dynamic> {
  String getString(String key, {String defaultValue = ''}) => this[key] as String? ?? defaultValue;
  int getInt(String key, {int defaultValue = 0}) => (this[key] as num?)?.toInt() ?? defaultValue;
  bool getBool(String key, {bool defaultValue = false}) => this[key] as bool? ?? defaultValue;
  double getDouble(String key, {double defaultValue = 0.0}) => (this[key] as num?)?.toDouble() ?? defaultValue;
  Map<String, dynamic> getMap(String key) => (this[key] as Map<dynamic, dynamic>?)?.map((k, v) => MapEntry(k.toString(), v)) ?? {};
  List<T> getList<T>(String key) => (this[key] as List<dynamic>?)?.cast<T>() ?? [];
  Map<String, dynamic> withoutNulls() => Map.fromEntries(entries.where((e) => e.value != null));
}
