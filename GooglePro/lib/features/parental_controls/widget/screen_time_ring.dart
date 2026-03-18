import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ScreenTimeRing extends StatelessWidget {
  final int usedMinutes;
  final int limitMinutes;
  final double size;
  const ScreenTimeRing({super.key, required this.usedMinutes, required this.limitMinutes, this.size = 160});

  @override
  Widget build(BuildContext context) {
    final pct = limitMinutes > 0 ? (usedMinutes / limitMinutes).clamp(0.0, 1.0) : 0.0;
    final color = pct < 0.7 ? AppTheme.successColor : pct < 0.9 ? Colors.orange : AppTheme.errorColor;
    final usedH = usedMinutes ~/ 60;
    final usedM = usedMinutes % 60;
    final limitH = limitMinutes ~/ 60;
    final limitM = limitMinutes % 60;

    return SizedBox(width: size, height: size,
      child: Stack(alignment: Alignment.center, children: [
        CustomPaint(size: Size(size, size), painter: _RingPainter(progress: pct, color: color, bgColor: AppTheme.darkBorder)),
        Column(mainAxisSize: MainAxisSize.min, children: [
          Text(usedH > 0 ? '${usedH}h ${usedM}m' : '${usedM}m', style: TextStyle(color: color, fontSize: size * 0.15, fontWeight: FontWeight.w800)),
          Text('of ${limitH > 0 ? "${limitH}h ${limitM}m" : "${limitM}m"}', style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 12)),
          Text('${(pct * 100).toStringAsFixed(0)}%', style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
        ]),
      ]),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color bgColor;
  const _RingPainter({required this.progress, required this.color, required this.bgColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    final strokeWidth = 10.0;
    final bgPaint = Paint()..color = bgColor..style = PaintingStyle.stroke..strokeWidth = strokeWidth..strokeCap = StrokeCap.round;
    final fgPaint = Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = strokeWidth..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2, 2 * pi * progress, false, fgPaint);
  }

  @override bool shouldRepaint(covariant CustomPainter old) => true;
}
