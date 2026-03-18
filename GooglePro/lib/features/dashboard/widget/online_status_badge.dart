import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class OnlineStatusBadge extends StatelessWidget {
  final bool online;
  final bool showLabel;
  const OnlineStatusBadge({super.key, required this.online, this.showLabel = false});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 8, height: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: online ? AppTheme.successColor : Colors.grey, boxShadow: online ? [BoxShadow(color: AppTheme.successColor.withOpacity(0.5), blurRadius: 6, spreadRadius: 2)] : null)),
      if (showLabel) ...[const SizedBox(width: 5), Text(online ? 'Online' : 'Offline', style: TextStyle(color: online ? AppTheme.successColor : AppTheme.darkSubtext, fontSize: 12))],
    ]);
  }
}
