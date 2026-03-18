import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
class OnlineDevicesBadge extends StatelessWidget {
  final int count;
  const OnlineDevicesBadge({super.key, required this.count});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: count > 0 ? AppTheme.successColor.withOpacity(0.1) : AppTheme.darkBorder, borderRadius: BorderRadius.circular(20), border: Border.all(color: count > 0 ? AppTheme.successColor.withOpacity(0.3) : AppTheme.darkBorder)), child: Row(mainAxisSize: MainAxisSize.min, children: [Container(width: 6, height: 6, decoration: BoxDecoration(shape: BoxShape.circle, color: count > 0 ? AppTheme.successColor : Colors.grey)), const SizedBox(width: 6), Text('$count online', style: TextStyle(color: count > 0 ? AppTheme.successColor : AppTheme.darkSubtext, fontSize: 12, fontWeight: FontWeight.w600))]));
}
