import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
class CallDurationTimer extends StatefulWidget {
  final DateTime startedAt;
  const CallDurationTimer({super.key, required this.startedAt});
  @override State<CallDurationTimer> createState() => _CallDurationTimerState();
}
class _CallDurationTimerState extends State<CallDurationTimer> {
  Timer? _timer;
  Duration _duration = Duration.zero;
  @override void initState() { super.initState(); _timer = Timer.periodic(const Duration(seconds: 1), (_) => setState(() => _duration = DateTime.now().difference(widget.startedAt))); }
  @override void dispose() { _timer?.cancel(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    final m = _duration.inMinutes.toString().padLeft(2, '0');
    final s = _duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return Text('$m:$s', style: const TextStyle(color: AppTheme.primaryColor, fontSize: 20, fontWeight: FontWeight.w600, fontFeatures: [FontFeature.tabularFigures()]));
  }
}
