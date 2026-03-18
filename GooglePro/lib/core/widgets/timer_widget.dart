import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
class TimerWidget extends StatefulWidget {
  final DateTime startTime;
  final TextStyle? style;
  const TimerWidget({super.key, required this.startTime, this.style});
  @override State<TimerWidget> createState() => _TimerWidgetState();
}
class _TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  Duration _elapsed = Duration.zero;
  @override void initState() { super.initState(); _timer = Timer.periodic(const Duration(seconds: 1), (_) => setState(() => _elapsed = DateTime.now().difference(widget.startTime))); }
  @override void dispose() { _timer.cancel(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    final h = _elapsed.inHours.toString().padLeft(2, '0');
    final m = _elapsed.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = _elapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
    return Text(_elapsed.inHours > 0 ? '$h:$m:$s' : '$m:$s', style: widget.style ?? const TextStyle(color: AppTheme.primaryColor, fontSize: 14, fontWeight: FontWeight.w600, fontFeatures: [FontFeature.tabularFigures()]));
  }
}
