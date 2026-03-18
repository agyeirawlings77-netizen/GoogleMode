import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
class ColorPickerWidget extends StatelessWidget {
  final List<Color> colors;
  final Color selected;
  final ValueChanged<Color> onSelected;
  const ColorPickerWidget({super.key, required this.colors, required this.selected, required this.onSelected});
  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 10, runSpacing: 10, children: colors.map((c) => GestureDetector(onTap: () => onSelected(c),
      child: AnimatedContainer(duration: const Duration(milliseconds: 200), width: 40, height: 40, decoration: BoxDecoration(shape: BoxShape.circle, color: c, border: Border.all(color: selected == c ? Colors.white : Colors.transparent, width: 3), boxShadow: selected == c ? [BoxShadow(color: c.withOpacity(0.5), blurRadius: 8, spreadRadius: 2)] : null)))).toList());
  }
}
