import 'package:flutter/material.dart';
import '../model/webrtc_state.dart';
import '../../../core/theme/app_theme.dart';
class IceStateIndicator extends StatelessWidget {
  final IceConnectionState state;
  const IceStateIndicator({super.key, required this.state});
  @override
  Widget build(BuildContext context) {
    Color color;
    String label;
    switch (state) {
      case IceConnectionState.connected: color = AppTheme.successColor; label = 'P2P'; break;
      case IceConnectionState.checking: color = AppTheme.warningColor; label = 'ICE'; break;
      case IceConnectionState.failed: color = AppTheme.errorColor; label = 'FAIL'; break;
      default: color = AppTheme.darkSubtext; label = 'IDLE';
    }
    return Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(4), border: Border.all(color: color.withOpacity(0.3))), child: Text(label, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 0.5)));
  }
}
