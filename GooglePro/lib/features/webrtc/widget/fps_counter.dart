import 'package:flutter/material.dart';
import '../model/connection_stats.dart';
class FpsCounter extends StatelessWidget {
  final ConnectionStats stats;
  const FpsCounter({super.key, required this.stats});
  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(6)),
      child: Text('${stats.fps.toStringAsFixed(0)} FPS', style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600)));
  }
}
