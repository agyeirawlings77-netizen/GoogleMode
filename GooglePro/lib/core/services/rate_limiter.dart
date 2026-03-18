class RateLimiter {
  final Map<String, DateTime> _lastCall = {};
  final Duration interval;
  RateLimiter({this.interval = const Duration(seconds: 1)});
  bool allow(String key) {
    final last = _lastCall[key];
    final now = DateTime.now();
    if (last == null || now.difference(last) >= interval) { _lastCall[key] = now; return true; }
    return false;
  }
}
