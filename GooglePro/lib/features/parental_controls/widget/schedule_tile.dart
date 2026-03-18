import 'package:flutter/material.dart';
import '../model/schedule_model.dart';
import '../../../core/theme/app_theme.dart';

class ScheduleTile extends StatelessWidget {
  final ScheduleModel schedule;
  final ValueChanged<bool> onToggle;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  const ScheduleTile({super.key, required this.schedule, required this.onToggle, this.onEdit, this.onDelete});

  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    return Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: schedule.enabled ? AppTheme.primaryColor.withOpacity(0.3) : AppTheme.darkBorder)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: Text(schedule.name, style: const TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w600))),
          Switch(value: schedule.enabled, onChanged: onToggle, activeColor: AppTheme.primaryColor),
        ]),
        const SizedBox(height: 4),
        Text('${_pad(schedule.window.startHour)}:${_pad(schedule.window.startMinute)} – ${_pad(schedule.window.endHour)}:${_pad(schedule.window.endMinute)}', style: const TextStyle(color: AppTheme.primaryColor, fontSize: 13)),
        const SizedBox(height: 6),
        Wrap(spacing: 4, children: List.generate(7, (i) {
          final active = schedule.activeDays.contains(i + 1);
          return Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: active ? AppTheme.primaryColor.withOpacity(0.15) : Colors.transparent, borderRadius: BorderRadius.circular(6), border: Border.all(color: active ? AppTheme.primaryColor.withOpacity(0.4) : AppTheme.darkBorder)),
            child: Text(_days[i], style: TextStyle(color: active ? AppTheme.primaryColor : AppTheme.darkSubtext, fontSize: 10, fontWeight: FontWeight.w600)));
        })),
      ]));
  }

  String _pad(int v) => v.toString().padLeft(2, '0');
}
