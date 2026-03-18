import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class WalkieTalkieScreen extends StatefulWidget {
  final String deviceId;
  const WalkieTalkieScreen({super.key, required this.deviceId});
  @override State<WalkieTalkieScreen> createState() => _WalkieTalkieScreenState();
}

class _WalkieTalkieScreenState extends State<WalkieTalkieScreen> {
  bool _isPushing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppTheme.darkBg,
      appBar: AppBar(title: const Text('Walkie Talkie', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        AnimatedContainer(duration: const Duration(milliseconds: 150), width: _isPushing ? 140 : 120, height: _isPushing ? 140 : 120, decoration: BoxDecoration(shape: BoxShape.circle, color: _isPushing ? AppTheme.errorColor : AppTheme.primaryColor, boxShadow: [BoxShadow(color: (_isPushing ? AppTheme.errorColor : AppTheme.primaryColor).withOpacity(0.4), blurRadius: _isPushing ? 30 : 15, spreadRadius: _isPushing ? 10 : 5)]),
          child: GestureDetector(
            onTapDown: (_) => setState(() => _isPushing = true),
            onTapUp: (_) => setState(() => _isPushing = false),
            onTapCancel: () => setState(() => _isPushing = false),
            child: Icon(_isPushing ? Icons.mic_rounded : Icons.mic_none_rounded, color: Colors.white, size: 56))).animate(onPlay: (c) => _isPushing ? c.repeat() : c.reset()),
        const SizedBox(height: 32),
        Text(_isPushing ? 'Transmitting...' : 'Hold to Talk', style: TextStyle(color: _isPushing ? AppTheme.primaryColor : AppTheme.darkSubtext, fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        const Text('Release to stop', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 13)),
      ])));
  }
}
