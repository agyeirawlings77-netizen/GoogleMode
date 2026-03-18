import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class TwoFactorScreen extends StatefulWidget {
  const TwoFactorScreen({super.key});
  @override State<TwoFactorScreen> createState() => _TwoFactorScreenState();
}

class _TwoFactorScreenState extends State<TwoFactorScreen> {
  final List<TextEditingController> _ctrls = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _nodes = List.generate(6, (_) => FocusNode());
  bool _loading = false;

  String get _code => _ctrls.map((c) => c.text).join();

  void _onDigit(int i, String v) {
    if (v.length == 1 && i < 5) _nodes[i + 1].requestFocus();
    if (v.isEmpty && i > 0) _nodes[i - 1].requestFocus();
  }

  void _verify() {
    if (_code.length != 6) return;
    setState(() => _loading = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) { setState(() => _loading = false); context.go('/dashboard'); }
    });
  }

  @override
  void dispose() { for (final c in _ctrls) c.dispose(); for (final n in _nodes) n.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: SafeArea(child: Padding(padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 20),
          const Text('Two-Factor Auth', style: TextStyle(color: AppTheme.darkText, fontSize: 28, fontWeight: FontWeight.w700)).animate().fadeIn(),
          const SizedBox(height: 8),
          const Text('Enter the 6-digit code from your authenticator app', style: TextStyle(color: AppTheme.darkSubtext)).animate().fadeIn(delay: 100.ms),
          const SizedBox(height: 48),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(6, (i) => SizedBox(width: 46, height: 56,
              child: TextField(controller: _ctrls[i], focusNode: _nodes[i],
                maxLength: 1, keyboardType: TextInputType.number, textAlign: TextAlign.center,
                style: const TextStyle(color: AppTheme.darkText, fontSize: 22, fontWeight: FontWeight.w700),
                decoration: InputDecoration(counterText: '', filled: true, fillColor: AppTheme.darkCard,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.darkBorder)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2))),
                onChanged: (v) => _onDigit(i, v),
              )).animate().fadeIn(delay: Duration(milliseconds: 100 + i * 50))),
          const SizedBox(height: 40),
          SizedBox(width: double.infinity, height: 54,
            child: ElevatedButton(onPressed: _loading ? null : _verify,
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
              child: _loading ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black))
                  : const Text('Verify', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)))),
        ]))),
    );
  }
}
