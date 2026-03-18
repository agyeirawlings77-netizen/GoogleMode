import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class StatusDot extends StatelessWidget {
  final bool online;
  final double size;
  final bool animated;
  const StatusDot({super.key, required this.online, this.size = 10, this.animated = false});

  @override
  Widget build(BuildContext context) {
    final color = online ? AppTheme.successColor : Colors.grey;
    Widget dot = Container(width: size, height: size, decoration: BoxDecoration(shape: BoxShape.circle, color: color, boxShadow: online ? [BoxShadow(color: color.withOpacity(0.5), blurRadius: 6, spreadRadius: 2)] : null));
    if (animated && online) return dot.animate(onPlay: (c) => c.repeat(reverse: true)).scaleXY(begin: 0.8, end: 1.2, duration: 1000.ms);
    return dot;
  }
}
