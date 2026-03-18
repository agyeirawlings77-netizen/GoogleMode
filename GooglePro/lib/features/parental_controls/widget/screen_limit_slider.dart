import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ScreenLimitSlider extends StatefulWidget {
  final int initialMinutes;
  final ValueChanged<int> onChanged;
  const ScreenLimitSlider({super.key, required this.initialMinutes, required this.onChanged});
  @override State<ScreenLimitSlider> createState() => _ScreenLimitSliderState();
}

class _ScreenLimitSliderState extends State<ScreenLimitSlider> {
  late int _minutes;
  @override void initState() { super.initState(); _minutes = widget.initialMinutes; }

  String get _label { final h = _minutes ~/ 60; final m = _minutes % 60; return h > 0 ? '${h}h ${m > 0 ? "${m}m" : ""}' : '${m}m'; }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text('Daily Screen Limit', style: TextStyle(color: AppTheme.darkText, fontSize: 14, fontWeight: FontWeight.w600)),
        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
          child: Text(_label, style: const TextStyle(color: AppTheme.primaryColor, fontSize: 13, fontWeight: FontWeight.w700))),
      ]),
      const SizedBox(height: 8),
      Slider(value: _minutes.toDouble(), min: 15, max: 720, divisions: 47, activeColor: AppTheme.primaryColor, inactiveColor: AppTheme.darkBorder,
        onChanged: (v) { setState(() => _minutes = v.round()); widget.onChanged(_minutes); }),
      const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('15m', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 11)),
        Text('12h', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 11)),
      ]),
    ]);
  }
}
