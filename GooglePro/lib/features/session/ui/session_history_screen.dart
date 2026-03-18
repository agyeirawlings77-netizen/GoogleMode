import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/date_formatter.dart';

class _FakeSession {
  final String deviceName;
  final DateTime startedAt;
  final Duration duration;
  final String type;
  const _FakeSession({required this.deviceName, required this.startedAt, required this.duration, required this.type});
}

class SessionHistoryScreen extends StatelessWidget {
  const SessionHistoryScreen({super.key});

  static final _sessions = [
    _FakeSession(deviceName: 'Samsung Galaxy S24', startedAt: DateTime.now().subtract(const Duration(hours: 2)), duration: const Duration(minutes: 23), type: 'Screen Share'),
    _FakeSession(deviceName: 'iPhone 15 Pro', startedAt: DateTime.now().subtract(const Duration(days: 1)), duration: const Duration(minutes: 8), type: 'Voice Call'),
    _FakeSession(deviceName: 'Infinix Hot 30', startedAt: DateTime.now().subtract(const Duration(days: 2)), duration: const Duration(minutes: 45), type: 'Remote Control'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(title: const Text('Session History', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: ListView.builder(padding: const EdgeInsets.all(16), itemCount: _sessions.length, itemBuilder: (ctx, i) {
        final s = _sessions[i];
        return Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.darkBorder)),
          child: Row(children: [
            Container(width: 44, height: 44, decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.screen_share_rounded, color: AppTheme.primaryColor, size: 22)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(s.deviceName, style: const TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w600, fontSize: 14)),
              Text('${s.type} • ${DateFormatter.formatDuration(s.duration)}', style: const TextStyle(color: AppTheme.primaryColor, fontSize: 12)),
            ])),
            Text(DateFormatter.timeAgo(s.startedAt), style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 11)),
          ]));
      }),
    );
  }
}
