import 'package:flutter/material.dart';
import '../model/connection_stats.dart';
class BitrateDisplay extends StatelessWidget {
  final ConnectionStats stats;
  const BitrateDisplay({super.key, required this.stats});
  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(6)),
      child: Text('${stats.bitrateKbps.toStringAsFixed(0)} kbps', style: const TextStyle(color: Colors.white70, fontSize: 11)));
  }
}
