import 'package:flutter/material.dart';
import '../model/app_notification.dart';
import '../../../core/theme/app_theme.dart';

class NotificationTile extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onTap;
  const NotificationTile({super.key, required this.notification, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(margin: const EdgeInsets.only(bottom: 8), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: notification.isRead ? AppTheme.darkBorder : AppTheme.primaryColor.withOpacity(0.3))),
      child: ListTile(onTap: onTap, contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        leading: Container(width: 42, height: 42, decoration: BoxDecoration(color: _color(notification.type).withOpacity(0.12), shape: BoxShape.circle), child: Icon(_icon(notification.type), color: _color(notification.type), size: 20)),
        title: Text(notification.title, style: TextStyle(color: AppTheme.darkText, fontWeight: notification.isRead ? FontWeight.normal : FontWeight.w600, fontSize: 14)),
        subtitle: Text(notification.body, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
          Text(_timeAgo(notification.timestamp), style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 10)),
          if (!notification.isRead) Container(width: 8, height: 8, margin: const EdgeInsets.only(top: 4), decoration: const BoxDecoration(shape: BoxShape.circle, color: AppTheme.primaryColor)),
        ])));
  }

  IconData _icon(NotificationType t) { switch (t) { case NotificationType.connection: return Icons.link; case NotificationType.message: return Icons.chat_bubble_outline; case NotificationType.alert: return Icons.warning_amber_rounded; case NotificationType.update: return Icons.system_update_outlined; case NotificationType.location: return Icons.location_on_outlined; case NotificationType.fileTransfer: return Icons.attach_file; case NotificationType.system: return Icons.info_outline; } }
  Color _color(NotificationType t) { switch (t) { case NotificationType.alert: return AppTheme.errorColor; case NotificationType.message: return AppTheme.accentColor; case NotificationType.connection: return AppTheme.successColor; default: return AppTheme.primaryColor; } }
  String _timeAgo(DateTime dt) { final d = DateTime.now().difference(dt); if (d.inMinutes < 60) return '${d.inMinutes}m'; if (d.inHours < 24) return '${d.inHours}h'; return '${d.inDays}d'; }
}
