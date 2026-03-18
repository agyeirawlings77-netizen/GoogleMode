import 'package:flutter/material.dart';
import '../model/connection_stats.dart';
import '../../../core/theme/app_theme.dart';
class QualityIndicator extends StatelessWidget {
  final ConnectionStats stats;
  const QualityIndicator({super.key, required this.stats});
  @override
  Widget build(BuildContext context) {
    final c = _color(stats.quality);
    return Row(mainAxisSize: MainAxisSize.min, children: [
      ...List.generate(4, (i) => Container(width: 4, height: 8 + i * 4.0, margin: const EdgeInsets.only(right: 2), decoration: BoxDecoration(color: i < _bars(stats.quality) ? c : c.withOpacity(0.2), borderRadius: BorderRadius.circular(2)))),
      const SizedBox(width: 6),
      Text(stats.quality, style: TextStyle(color: c, fontSize: 11, fontWeight: FontWeight.w600)),
    ]);
  }
  Color _color(String q) { switch (q) { case 'Excellent': return AppTheme.successColor; case 'Good': return Colors.greenAccent; case 'Fair': return Colors.orange; default: return AppTheme.errorColor; } }
  int _bars(String q) { switch (q) { case 'Excellent': return 4; case 'Good': return 3; case 'Fair': return 2; default: return 1; } }
}
