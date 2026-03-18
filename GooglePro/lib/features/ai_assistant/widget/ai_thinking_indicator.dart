import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
class AiThinkingIndicator extends StatelessWidget {
  const AiThinkingIndicator({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(margin: const EdgeInsets.only(right: 60, bottom: 12), padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: const BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18), bottomRight: Radius.circular(18), bottomLeft: Radius.circular(4))),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const Text('Thinking', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 12)),
        const SizedBox(width: 8),
        ...List.generate(3, (i) => Container(width: 5, height: 5, margin: const EdgeInsets.only(right: 3), decoration: const BoxDecoration(shape: BoxShape.circle, color: AppTheme.primaryColor))
          .animate(delay: Duration(milliseconds: i * 200), onPlay: (c) => c.repeat(reverse: true)).scaleXY(begin: 0.4, end: 1.0, duration: 400.ms)),
      ]));
  }
}
