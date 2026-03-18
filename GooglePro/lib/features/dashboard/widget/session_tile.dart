import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
class SessionTile extends StatelessWidget {
  final String deviceName;
  final String sessionId;
  final bool isLive;
  final VoidCallback onTap;
  const SessionTile({super.key, required this.deviceName, required this.sessionId, required this.isLive, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return ListTile(onTap: onTap,
      leading: Container(width: 42, height: 42, decoration: BoxDecoration(color: isLive ? AppTheme.primaryColor.withOpacity(0.15) : AppTheme.darkCard, borderRadius: BorderRadius.circular(10)),
        child: Icon(Icons.cast_connected, color: isLive ? AppTheme.primaryColor : AppTheme.darkSubtext, size: 20)),
      title: Text(deviceName, style: const TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w600, fontSize: 14)),
      subtitle: Text(isLive ? 'Live session' : 'Session: $sessionId', style: TextStyle(color: isLive ? AppTheme.primaryColor : AppTheme.darkSubtext, fontSize: 12)),
      trailing: isLive ? Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.15), borderRadius: BorderRadius.circular(6)), child: const Text('LIVE', style: TextStyle(color: AppTheme.primaryColor, fontSize: 11, fontWeight: FontWeight.w700))) : null);
  }
}
