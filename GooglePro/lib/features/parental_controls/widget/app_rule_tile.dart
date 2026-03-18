import 'package:flutter/material.dart';
import '../model/app_usage_rule.dart';
import '../../../core/theme/app_theme.dart';

class AppRuleTile extends StatelessWidget {
  final AppUsageRule rule;
  final ValueChanged<bool> onToggle;
  final VoidCallback onDelete;
  const AppRuleTile({super.key, required this.rule, required this.onToggle, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: rule.isBlocked ? AppTheme.errorColor.withOpacity(0.3) : AppTheme.darkBorder)),
      child: ListTile(
        leading: Container(width: 42, height: 42, decoration: BoxDecoration(color: _catColor(rule.category).withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
          child: Icon(_catIcon(rule.category), color: _catColor(rule.category), size: 22)),
        title: Text(rule.appName, style: const TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w600, fontSize: 14)),
        subtitle: Text(_subtitle(rule), style: TextStyle(color: rule.isBlocked ? AppTheme.errorColor : AppTheme.darkSubtext, fontSize: 12)),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          Switch(value: rule.isBlocked, onChanged: onToggle, activeColor: AppTheme.errorColor),
          IconButton(icon: const Icon(Icons.delete_outline, color: AppTheme.darkSubtext, size: 18), onPressed: onDelete),
        ]),
      ),
    );
  }

  String _subtitle(AppUsageRule r) {
    if (r.isBlocked) return 'Blocked';
    if (r.dailyLimitMinutes != null) { final h = r.dailyLimitMinutes! ~/ 60; final m = r.dailyLimitMinutes! % 60; return 'Limit: ${h > 0 ? "${h}h " : ""}${m}m/day'; }
    return r.category.name;
  }

  Color _catColor(AppCategory c) { switch (c) { case AppCategory.social: return Colors.blue; case AppCategory.games: return Colors.orange; case AppCategory.entertainment: return Colors.purple; case AppCategory.education: return AppTheme.successColor; default: return AppTheme.primaryColor; } }
  IconData _catIcon(AppCategory c) { switch (c) { case AppCategory.social: return Icons.people; case AppCategory.games: return Icons.gamepad; case AppCategory.entertainment: return Icons.movie; case AppCategory.education: return Icons.school; default: return Icons.apps; } }
}
