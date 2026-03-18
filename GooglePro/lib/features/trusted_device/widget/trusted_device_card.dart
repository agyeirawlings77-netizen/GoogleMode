import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
class TrustedDeviceCard extends StatelessWidget {
  final String deviceName;
  final bool autoConnect;
  final bool isOnline;
  final ValueChanged<bool> onToggleAutoConnect;
  final VoidCallback onRemove;
  const TrustedDeviceCard({super.key, required this.deviceName, required this.autoConnect, required this.isOnline, required this.onToggleAutoConnect, required this.onRemove});
  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: autoConnect ? AppTheme.primaryColor.withOpacity(0.25) : AppTheme.darkBorder)),
      child: Row(children: [
        Stack(children: [
          Container(width: 44, height: 44, decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.verified_rounded, color: AppTheme.primaryColor, size: 22)),
          if (isOnline) Positioned(bottom: 0, right: 0, child: Container(width: 11, height: 11, decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.successColor, border: Border.all(color: AppTheme.darkCard, width: 2)))),
        ]),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(deviceName, style: const TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w600)),
          Text(isOnline ? 'Online' : 'Last seen recently', style: TextStyle(color: isOnline ? AppTheme.successColor : AppTheme.darkSubtext, fontSize: 11)),
        ])),
        Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('Auto', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 9)),
          Switch(value: autoConnect, onChanged: onToggleAutoConnect, activeColor: AppTheme.primaryColor),
        ]),
        IconButton(icon: const Icon(Icons.delete_outline, color: AppTheme.errorColor, size: 18), onPressed: onRemove),
      ]));
  }
}
