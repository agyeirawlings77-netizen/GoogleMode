import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../model/chat_message.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/date_formatter.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final int index;
  const MessageBubble({super.key, required this.message, this.index = 0});

  @override
  Widget build(BuildContext context) {
    final myUid = FirebaseAuth.instance.currentUser?.uid ?? '';
    final isMe = message.senderId == myUid;
    return Padding(
      padding: EdgeInsets.only(left: isMe ? 60 : 0, right: isMe ? 0 : 60, bottom: 8),
      child: Row(mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.end, children: [
        if (!isMe) ...[
          CircleAvatar(radius: 14, backgroundColor: AppTheme.primaryColor.withOpacity(0.15), child: Text(message.senderName.isNotEmpty ? message.senderName[0].toUpperCase() : '?', style: const TextStyle(color: AppTheme.primaryColor, fontSize: 11, fontWeight: FontWeight.w700))),
          const SizedBox(width: 6),
        ],
        Flexible(child: Column(crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start, children: [
          if (!isMe) Padding(padding: const EdgeInsets.only(left: 4, bottom: 2), child: Text(message.senderName, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 11))),
          Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10), decoration: BoxDecoration(color: isMe ? AppTheme.primaryColor : AppTheme.darkCard, borderRadius: BorderRadius.only(topLeft: const Radius.circular(18), topRight: const Radius.circular(18), bottomLeft: Radius.circular(isMe ? 18 : 4), bottomRight: Radius.circular(isMe ? 4 : 18))),
            child: Text(message.text ?? '', style: TextStyle(color: isMe ? Colors.black : AppTheme.darkText, fontSize: 14, height: 1.4))),
          Padding(padding: const EdgeInsets.only(top: 2, left: 4, right: 4), child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text(DateFormatter.formatTime(message.timestamp), style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 10)),
            if (isMe) ...[const SizedBox(width: 4), Icon(_statusIcon(message.status), size: 12, color: _statusColor(message.status))],
          ])),
        ])),
      ]),
    ).animate().fadeIn(delay: Duration(milliseconds: index < 10 ? index * 30 : 0)).slideY(begin: 0.05);
  }

  IconData _statusIcon(MessageStatus s) { switch (s) { case MessageStatus.sending: return Icons.access_time; case MessageStatus.sent: return Icons.check; case MessageStatus.delivered: return Icons.done_all; case MessageStatus.read: return Icons.done_all; case MessageStatus.failed: return Icons.error_outline; } }
  Color _statusColor(MessageStatus s) { switch (s) { case MessageStatus.read: return AppTheme.primaryColor; case MessageStatus.failed: return AppTheme.errorColor; default: return AppTheme.darkSubtext; } }
}
