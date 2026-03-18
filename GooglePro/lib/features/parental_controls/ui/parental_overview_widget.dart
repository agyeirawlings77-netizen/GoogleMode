import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
class ParentalOverviewWidget extends StatelessWidget {
  final String childName;
  final int screenTimeUsed;
  final int screenTimeLimit;
  final bool isActive;
  const ParentalOverviewWidget({super.key, required this.childName, required this.screenTimeUsed, required this.screenTimeLimit, required this.isActive});
  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: isActive ? AppTheme.primaryColor.withOpacity(0.3) : AppTheme.darkBorder)),
      child: Row(children: [
        Container(width: 44, height: 44, decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.1), shape: BoxShape.circle), child: const Icon(Icons.child_care, color: AppTheme.primaryColor, size: 22)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(childName, style: const TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w600)),
          Text('${screenTimeUsed ~/ 60}h ${screenTimeUsed % 60}m / ${screenTimeLimit ~/ 60}h', style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 12)),
        ])),
        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: isActive ? AppTheme.successColor.withOpacity(0.1) : AppTheme.darkBorder, borderRadius: BorderRadius.circular(8)), child: Text(isActive ? 'Active' : 'Paused', style: TextStyle(color: isActive ? AppTheme.successColor : AppTheme.darkSubtext, fontSize: 11, fontWeight: FontWeight.w600))),
      ]));
  }
}
