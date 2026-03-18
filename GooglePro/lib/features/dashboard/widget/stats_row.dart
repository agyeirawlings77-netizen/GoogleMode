import 'package:flutter/material.dart';
import '../model/dashboard_stats.dart';
import '../../../core/theme/app_theme.dart';

class StatsRow extends StatelessWidget {
  final DashboardStats stats;
  const StatsRow({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      _statCard('${stats.onlineDevices}', 'Online', AppTheme.successColor, Icons.wifi_rounded),
      const SizedBox(width: 10),
      _statCard('${stats.totalDevices}', 'Devices', AppTheme.primaryColor, Icons.devices_rounded),
      const SizedBox(width: 10),
      _statCard('${stats.totalSessions}', 'Sessions', AppTheme.accentColor, Icons.screen_share_rounded),
    ]);
  }

  Widget _statCard(String value, String label, Color color, IconData icon) {
    return Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.2))),
      child: Column(children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 6),
        Text(value, style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.w800)),
        Text(label, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 11)),
      ])));
  }
}
