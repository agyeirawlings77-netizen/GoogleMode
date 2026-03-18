extension ListExtensions<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
  T? get lastOrNull => isEmpty ? null : last;
  T? firstWhereOrNull(bool Function(T) test) { try { return firstWhere(test); } catch (_) { return null; } }
  List<T> insertBetween(T separator) {
    if (length <= 1) return this;
    final result = <T>[];
    for (int i = 0; i < length; i++) { result.add(this[i]); if (i < length - 1) result.add(separator); }
    return result;
  }
  List<List<T>> chunked(int size) {
    final chunks = <List<T>>[];
    for (int i = 0; i < length; i += size) { chunks.add(sublist(i, i + size > length ? length : i + size)); }
    return chunks;
  }
  Map<K, List<T>> groupBy<K>(K Function(T) keyFn) {
    final map = <K, List<T>>{};
    for (final item in this) { (map[keyFn(item)] ??= []).add(item); }
    return map;
  }
  List<T> distinctBy<K>(K Function(T) keyFn) {
    final seen = <K>{};
    return where((item) => seen.add(keyFn(item))).toList();
  }
}
