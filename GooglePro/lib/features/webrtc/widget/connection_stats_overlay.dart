import 'package:flutter/material.dart';
import '../model/webrtc_state.dart';
import '../../../core/theme/app_theme.dart';

class ConnectionStatsOverlay extends StatelessWidget {
  final WebRtcStats stats;
  final bool visible;
  const ConnectionStatsOverlay({super.key, required this.stats, this.visible = true});
  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();
    final qualColor = stats.qualityScore > 0.7 ? AppTheme.successColor : stats.qualityScore > 0.4 ? AppTheme.warningColor : AppTheme.errorColor;
    return Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        Text('${stats.bitrateKbps.toStringAsFixed(0)} kbps', style: const TextStyle(color: Colors.white, fontSize: 11, fontFamily: 'monospace')),
        Text('${stats.latencyMs}ms RTT', style: TextStyle(color: stats.latencyMs > 200 ? AppTheme.warningColor : Colors.white, fontSize: 11, fontFamily: 'monospace')),
        Text('${stats.fps} fps', style: const TextStyle(color: Colors.white, fontSize: 11, fontFamily: 'monospace')),
        Text(stats.qualityLabel, style: TextStyle(color: qualColor, fontSize: 11, fontWeight: FontWeight.w700)),
      ]));
  }
}
