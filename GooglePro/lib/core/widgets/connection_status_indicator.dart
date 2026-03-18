import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

enum ConnectionIndicatorState { connected, connecting, disconnected }

class ConnectionStatusIndicator extends StatelessWidget {
  final ConnectionIndicatorState state;
  final String? label;
  const ConnectionStatusIndicator({super.key, required this.state, this.label});

  @override
  Widget build(BuildContext context) {
    Color color; IconData icon; String text;
    switch (state) {
      case ConnectionIndicatorState.connected: color = AppTheme.successColor; icon = Icons.wifi; text = label ?? 'Connected'; break;
      case ConnectionIndicatorState.connecting: color = Colors.orange; icon = Icons.wifi_find; text = label ?? 'Connecting...'; break;
      case ConnectionIndicatorState.disconnected: color = AppTheme.errorColor; icon = Icons.wifi_off; text = label ?? 'Disconnected'; break;
    }

    return Row(mainAxisSize: MainAxisSize.min, children: [
      if (state == ConnectionIndicatorState.connecting)
        SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 1.5, color: color)).animate(onPlay: (c) => c.repeat()).rotate(duration: 1000.ms)
      else
        Icon(icon, color: color, size: 14),
      const SizedBox(width: 6),
      Text(text, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500)),
    ]);
  }
}
