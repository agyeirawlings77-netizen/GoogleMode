import 'package:flutter/material.dart';
import '../model/focus_session.dart';
import '../../../core/theme/app_theme.dart';
class FocusModeCard extends StatelessWidget {
  final FocusSession? activeSession;
  final VoidCallback onStart;
  final VoidCallback? onStop;
  const FocusModeCard({super.key, this.activeSession, required this.onStart, this.onStop});
  @override
  Widget build(BuildContext context) {
    final isActive = activeSession?.isActive ?? false;
    return Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: isActive ? Colors.orange.withOpacity(0.3) : AppTheme.darkBorder)),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.orange.withOpacity(0.1), shape: BoxShape.circle), child: const Icon(Icons.center_focus_strong, color: Colors.orange, size: 24)),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Focus Mode', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w600)),
          Text(isActive ? 'Active – ${activeSession!.remaining.inMinutes}m remaining' : 'Block distractions', style: TextStyle(color: isActive ? Colors.orange : AppTheme.darkSubtext, fontSize: 12)),
        ])),
        isActive ? OutlinedButton(onPressed: onStop, style: OutlinedButton.styleFrom(foregroundColor: Colors.orange, side: const BorderSide(color: Colors.orange), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), child: const Text('Stop'))
          : ElevatedButton(onPressed: onStart, style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), child: const Text('Start', style: TextStyle(fontWeight: FontWeight.w700))),
      ]));
  }
}
