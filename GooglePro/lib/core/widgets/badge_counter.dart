import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
class BadgeCounter extends StatelessWidget {
  final int count;
  final Color color;
  final double size;
  const BadgeCounter({super.key, required this.count, this.color = AppTheme.errorColor, this.size = 18});
  @override
  Widget build(BuildContext context) {
    if (count == 0) return const SizedBox.shrink();
    return Container(constraints: BoxConstraints(minWidth: size, minHeight: size), padding: const EdgeInsets.symmetric(horizontal: 5), decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(size / 2)), child: Text(count > 99 ? '99+' : '$count', style: TextStyle(color: Colors.white, fontSize: size * 0.6, fontWeight: FontWeight.w700), textAlign: TextAlign.center));
  }
}
