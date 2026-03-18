import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? action;
  const SectionHeader({super.key, required this.title, this.action});
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(bottom: 12), child: Row(children: [
      Text(title.toUpperCase(), style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
      const Spacer(),
      if (action != null) action!,
    ]));
  }
}
