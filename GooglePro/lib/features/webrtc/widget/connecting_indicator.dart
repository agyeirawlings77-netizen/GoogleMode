import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';

class ConnectingIndicator extends StatelessWidget {
  final String deviceName;
  const ConnectingIndicator({super.key, required this.deviceName});

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppTheme.primaryColor, width: 2)),
        child: const Icon(Icons.cast_connected, color: AppTheme.primaryColor, size: 36))
        .animate(onPlay: (c) => c.repeat()).shimmer(duration: 1500.ms, color: AppTheme.primaryColor.withOpacity(0.4)),
      const SizedBox(height: 24),
      const Text('Connecting...', style: TextStyle(color: AppTheme.darkText, fontSize: 18, fontWeight: FontWeight.w600)),
      const SizedBox(height: 8),
      Text(deviceName, style: const TextStyle(color: AppTheme.primaryColor, fontSize: 14)),
      const SizedBox(height: 24),
      const SizedBox(width: 180, child: LinearProgressIndicator(color: AppTheme.primaryColor, backgroundColor: AppTheme.darkBorder)),
    ]));
  }
}
