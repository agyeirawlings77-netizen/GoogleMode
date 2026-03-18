import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const SettingsSection({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: const EdgeInsets.only(left: 4, bottom: 8),
        child: Text(title.toUpperCase(), style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2))),
      Container(decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.darkBorder)),
        child: Column(children: children.asMap().entries.map((e) {
          final isFirst = e.key == 0;
          final isLast = e.key == children.length - 1;
          return ClipRRect(borderRadius: BorderRadius.only(topLeft: Radius.circular(isFirst ? 16 : 0), topRight: Radius.circular(isFirst ? 16 : 0), bottomLeft: Radius.circular(isLast ? 16 : 0), bottomRight: Radius.circular(isLast ? 16 : 0)),
            child: Column(children: [e.value, if (!isLast) const Divider(height: 1, color: AppTheme.darkBorder, indent: 52)]));
        }).toList())),
      const SizedBox(height: 20),
    ]);
  }
}
