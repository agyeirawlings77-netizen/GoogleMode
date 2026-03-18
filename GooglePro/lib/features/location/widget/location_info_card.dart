import 'package:flutter/material.dart';
import '../model/location_point.dart';
import '../../../core/theme/app_theme.dart';

class LocationInfoCard extends StatelessWidget {
  final LocationPoint? location;
  final String label;
  final Color color;
  const LocationInfoCard({super.key, this.location, required this.label, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.2))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Container(width: 8, height: 8, margin: const EdgeInsets.only(right: 8), decoration: BoxDecoration(shape: BoxShape.circle, color: location != null ? AppTheme.successColor : Colors.grey)), Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w700))]),
        const SizedBox(height: 8),
        if (location != null) ...[
          Text(location!.formatted, style: const TextStyle(color: AppTheme.darkText, fontSize: 13, fontFamily: 'monospace')),
          if (location!.accuracy != null) Text('Accuracy: ±${location!.accuracy!.toStringAsFixed(0)}m', style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 11)),
          if (location!.speed != null && location!.speed! > 0) Text('Speed: ${(location!.speed! * 3.6).toStringAsFixed(1)} km/h', style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 11)),
        ] else const Text('No location data', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 12)),
      ]));
  }
}
