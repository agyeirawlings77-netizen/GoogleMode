import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
class ProgressRing extends StatelessWidget {
  final double progress;
  final double size;
  final Color color;
  final double strokeWidth;
  final Widget? child;
  const ProgressRing({super.key, required this.progress, this.size = 80, this.color = AppTheme.primaryColor, this.strokeWidth = 8, this.child});
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size, height: size, child: Stack(alignment: Alignment.center, children: [
      CustomPaint(size: Size(size, size), painter: _RingPainter(progress: progress.clamp(0.0, 1.0), color: color, strokeWidth: strokeWidth, bgColor: AppTheme.darkBorder)),
      if (child != null) child!,
    ]));
  }
}
class _RingPainter extends CustomPainter {
  final double progress; final Color color, bgColor; final double strokeWidth;
  const _RingPainter({required this.progress, required this.color, required this.strokeWidth, required this.bgColor});
  @override void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2); final r = (size.width - strokeWidth) / 2;
    canvas.drawCircle(c, r, Paint()..color = bgColor..style = PaintingStyle.stroke..strokeWidth = strokeWidth);
    canvas.drawArc(Rect.fromCircle(center: c, radius: r), -pi / 2, 2 * pi * progress, false, Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = strokeWidth..strokeCap = StrokeCap.round);
  }
  @override bool shouldRepaint(covariant CustomPainter old) => true;
}
