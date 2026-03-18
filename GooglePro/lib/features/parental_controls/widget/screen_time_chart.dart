import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../model/screen_time_model.dart';
import '../../../core/theme/app_theme.dart';

class ScreenTimeChart extends StatelessWidget {
  final List<ScreenTimeModel> weekData;
  const ScreenTimeChart({super.key, required this.weekData});

  @override
  Widget build(BuildContext context) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Container(
      height: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.darkBorder)),
      child: BarChart(BarChartData(
        maxY: 480,
        gridData: FlGridData(show: true, drawVerticalLine: false, horizontalInterval: 120, getDrawingHorizontalLine: (v) => FlLine(color: AppTheme.darkBorder, strokeWidth: 0.5)),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, m) => Text(days[v.toInt() % 7], style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 10)), reservedSize: 20)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, m) => Text('${v.toInt() ~/ 60}h', style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 9)), reservedSize: 22, interval: 120)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(7, (i) {
          final mins = i < weekData.length ? weekData[i].totalMinutes.toDouble() : 0.0;
          final isToday = i == DateTime.now().weekday - 1;
          return BarChartGroupData(x: i, barRods: [BarChartRodData(toY: mins.clamp(0, 480), color: isToday ? AppTheme.primaryColor : AppTheme.primaryColor.withOpacity(0.4), width: 18, borderRadius: BorderRadius.circular(4))]);
        }),
      )),
    );
  }
}
