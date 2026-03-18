import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
class UnreadBadge extends StatelessWidget {
  final int count;
  final Widget child;
  const UnreadBadge({super.key, required this.count, required this.child});
  @override
  Widget build(BuildContext context) {
    if (count == 0) return child;
    return Stack(children: [
      child,
      Positioned(right: 0, top: 0, child: Container(constraints: const BoxConstraints(minWidth: 16, minHeight: 16), padding: const EdgeInsets.all(2), decoration: const BoxDecoration(color: AppTheme.errorColor, shape: BoxShape.circle), child: Text(count > 99 ? '99+' : '$count', style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700), textAlign: TextAlign.center))),
    ]);
  }
}
