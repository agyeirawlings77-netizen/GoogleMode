import 'dart:async';
class DebounceService {
  Timer? _timer;
  final Duration delay;
  DebounceService({this.delay = const Duration(milliseconds: 500)});
  void run(void Function() fn) { _timer?.cancel(); _timer = Timer(delay, fn); }
  void cancel() => _timer?.cancel();
  void dispose() { _timer?.cancel(); _timer = null; }
}
