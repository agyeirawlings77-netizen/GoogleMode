import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../model/ai_message.dart';
import '../../../core/theme/app_theme.dart';

class AiMessageBubble extends StatelessWidget {
  final AiMessage message;
  const AiMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == AiMessageRole.user;
    return Padding(
      padding: EdgeInsets.only(left: isUser ? 60 : 0, right: isUser ? 0 : 60, bottom: 12),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(width: 32, height: 32, decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [AppTheme.primaryColor, AppTheme.accentColor])), child: const Icon(Icons.auto_awesome, color: Colors.black, size: 16)),
            const SizedBox(width: 8),
          ],
          Flexible(child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isUser ? AppTheme.primaryColor : AppTheme.darkCard,
              borderRadius: BorderRadius.only(topLeft: const Radius.circular(18), topRight: const Radius.circular(18), bottomLeft: Radius.circular(isUser ? 18 : 4), bottomRight: Radius.circular(isUser ? 4 : 18)),
            ),
            child: message.isLoading
              ? Row(mainAxisSize: MainAxisSize.min, children: [
                  ...List.generate(3, (i) => Container(width: 6, height: 6, margin: const EdgeInsets.symmetric(horizontal: 2), decoration: const BoxDecoration(shape: BoxShape.circle, color: AppTheme.darkSubtext))
                    .animate(delay: Duration(milliseconds: i * 200), onPlay: (c) => c.repeat(reverse: true)).scaleXY(begin: 0.5, end: 1.0, duration: 400.ms)),
                ])
              : Text(message.content, style: TextStyle(color: isUser ? Colors.black : AppTheme.darkText, fontSize: 14, height: 1.5)),
          )),
          if (isUser) const SizedBox(width: 8),
        ],
      ),
    );
  }
}
