import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
class ConnectionStatusBar extends StatelessWidget {
  final bool connected;
  final String? deviceName;
  const ConnectionStatusBar({super.key, required this.connected, this.deviceName});
  @override
  Widget build(BuildContext context) {
    if (!connected) return const SizedBox.shrink();
    return Container(margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: AppTheme.successColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.successColor.withOpacity(0.3))),
      child: Row(children: [
        Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppTheme.successColor)),
        const SizedBox(width: 8),
        Text('Connected to ${deviceName ?? 'device'}', style: const TextStyle(color: AppTheme.successColor, fontSize: 13, fontWeight: FontWeight.w500)),
        const Spacer(),
        const Icon(Icons.screen_share_rounded, color: AppTheme.successColor, size: 16),
      ]));
  }
}
