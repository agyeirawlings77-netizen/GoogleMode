import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
class ThemePreviewCard extends StatelessWidget {
  final Color accentColor;
  final bool isDark;
  final bool isSelected;
  final VoidCallback onTap;
  const ThemePreviewCard({super.key, required this.accentColor, required this.isDark, required this.isSelected, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final bg = isDark ? const Color(0xFF0A0E1A) : Colors.white;
    final card = isDark ? const Color(0xFF1A2235) : const Color(0xFFF5F5F5);
    return GestureDetector(onTap: onTap,
      child: AnimatedContainer(duration: const Duration(milliseconds: 200), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(16), border: Border.all(color: isSelected ? accentColor : Colors.transparent, width: 2)),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 80, height: 50, decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
            child: Column(children: [
              Container(height: 10, margin: const EdgeInsets.all(4), decoration: BoxDecoration(color: accentColor, borderRadius: BorderRadius.circular(3))),
              Row(children: [Container(height: 6, width: 30, margin: const EdgeInsets.symmetric(horizontal: 4), decoration: BoxDecoration(color: accentColor.withOpacity(0.4), borderRadius: BorderRadius.circular(2))), Container(height: 6, width: 20, margin: const EdgeInsets.only(left: 2), decoration: BoxDecoration(color: accentColor.withOpacity(0.2), borderRadius: BorderRadius.circular(2)))]),
            ])),
          const SizedBox(height: 6),
          if (isSelected) Icon(Icons.check_circle, color: accentColor, size: 16),
        ])));
  }
}
