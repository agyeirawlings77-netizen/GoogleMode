import 'package:flutter/material.dart';
import '../model/device_model_local.dart';
import '../../../core/theme/app_theme.dart';
class DeviceTypeSelector extends StatelessWidget {
  final DeviceTypeLocal selected;
  final ValueChanged<DeviceTypeLocal> onChanged;
  const DeviceTypeSelector({super.key, required this.selected, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Row(children: DeviceTypeLocal.values.where((t) => t != DeviceTypeLocal.unknown).map((t) {
      final isSelected = t == selected;
      return GestureDetector(onTap: () => onChanged(t), child: Container(margin: const EdgeInsets.only(right: 8), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : AppTheme.darkCard, borderRadius: BorderRadius.circular(10), border: Border.all(color: isSelected ? AppTheme.primaryColor.withOpacity(0.4) : AppTheme.darkBorder)), child: Text(t.name, style: TextStyle(color: isSelected ? AppTheme.primaryColor : AppTheme.darkSubtext, fontSize: 12, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal))));
    }).toList());
  }
}
