import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class DeviceAutoConnectBanner extends StatelessWidget {
  final String deviceName;
  final VoidCallback onConnect;
  final VoidCallback onDismiss;
  const DeviceAutoConnectBanner({super.key, required this.deviceName, required this.onConnect, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3))),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(8), decoration: const BoxDecoration(color: AppTheme.primaryColor, shape: BoxShape.circle), child: const Icon(Icons.link, color: Colors.black, size: 18)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Auto-connect available', style: TextStyle(color: AppTheme.primaryColor, fontSize: 13, fontWeight: FontWeight.w600)),
          Text(deviceName, style: const TextStyle(color: AppTheme.darkText, fontSize: 14, fontWeight: FontWeight.w500)),
        ])),
        TextButton(onPressed: onConnect, child: const Text('Connect', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.w700))),
        IconButton(icon: const Icon(Icons.close, color: AppTheme.darkSubtext, size: 18), onPressed: onDismiss),
      ]),
    );
  }
}
