import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
class AutoConnectOverlay extends StatelessWidget {
  final String deviceName;
  final VoidCallback onDismiss;
  const AutoConnectOverlay({super.key, required this.deviceName, required this.onDismiss});
  @override
  Widget build(BuildContext context) {
    return Positioned(top: 0, left: 0, right: 0, child: SafeArea(child: Container(margin: const EdgeInsets.all(12), padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.primaryColor.withOpacity(0.4)), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20)]),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(8), decoration: const BoxDecoration(color: AppTheme.primaryColor, shape: BoxShape.circle), child: const Icon(Icons.autorenew, color: Colors.black, size: 16)),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Auto-connected', style: TextStyle(color: AppTheme.primaryColor, fontSize: 12, fontWeight: FontWeight.w600)),
          Text(deviceName, style: const TextStyle(color: AppTheme.darkText, fontSize: 13, fontWeight: FontWeight.w500)),
        ])),
        IconButton(icon: const Icon(Icons.close, color: AppTheme.darkSubtext, size: 18), onPressed: onDismiss),
      ]))).animate().slideY(begin: -1, end: 0, duration: 400.ms, curve: Curves.easeOut));
  }
}
