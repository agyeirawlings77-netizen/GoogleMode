import 'package:flutter/material.dart';
import '../model/quick_action.dart';
import '../../../core/theme/app_theme.dart';

class QuickActionGrid extends StatelessWidget {
  final List<QuickAction> actions;
  final ValueChanged<QuickAction> onTap;
  const QuickActionGrid({super.key, required this.actions, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.85),
      itemCount: actions.length,
      itemBuilder: (ctx, i) {
        final a = actions[i];
        return GestureDetector(onTap: () => onTap(a),
          child: Container(decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: a.color.withOpacity(0.2))),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: a.color.withOpacity(0.12), shape: BoxShape.circle), child: Icon(a.icon, color: a.color, size: 22)),
              const SizedBox(height: 6),
              Text(a.label, textAlign: TextAlign.center, style: const TextStyle(color: AppTheme.darkText, fontSize: 10, fontWeight: FontWeight.w500), maxLines: 2, overflow: TextOverflow.ellipsis),
            ])));
      },
    );
  }
}
