import 'package:flutter/material.dart';
import '../model/screen_time_stats.dart';
import '../../../core/theme/app_theme.dart';

class AppUsageTile extends StatelessWidget {
  final AppUsageStat stat;
  final VoidCallback? onBlock;
  const AppUsageTile({super.key, required this.stat, this.onBlock});

  @override
  Widget build(BuildContext context) {
    final color = stat.isOverLimit ? AppTheme.errorColor : stat.usagePercent > 0.8 ? Colors.orange : AppTheme.primaryColor;
    return Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: stat.isOverLimit ? AppTheme.errorColor.withOpacity(0.3) : AppTheme.darkBorder)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(width: 40, height: 40, decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(Icons.apps, color: color, size: 22)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(stat.appName, style: const TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w600, fontSize: 14)),
            Text('${stat.usedMinutes ~/ 60}h ${stat.usedMinutes % 60}m used${stat.limitMinutes > 0 ? " / ${stat.limitMinutes ~/ 60}h ${stat.limitMinutes % 60}m" : ""}', style: TextStyle(color: color, fontSize: 11)),
          ])),
          if (onBlock != null) IconButton(icon: const Icon(Icons.block, color: AppTheme.errorColor, size: 20), onPressed: onBlock),
        ]),
        if (stat.limitMinutes > 0) ...[
          const SizedBox(height: 8),
          ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: stat.usagePercent, minHeight: 5, backgroundColor: AppTheme.darkBorder, valueColor: AlwaysStoppedAnimation<Color>(color))),
        ],
      ]));
  }
}
