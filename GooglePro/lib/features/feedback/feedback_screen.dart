import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/di/injection.dart';
import 'feedback_service.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});
  @override State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _ctrl = TextEditingController();
  String _type = 'general';
  int _rating = 5;
  bool _submitting = false;

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppTheme.darkBg,
      appBar: AppBar(title: const Text('Send Feedback', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const Text('TYPE', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
        const SizedBox(height: 8),
        Wrap(spacing: 8, children: ['general', 'bug', 'feature'].map((t) => FilterChip(label: Text(t.toUpperCase()), selected: _type == t, onSelected: (_) => setState(() => _type = t), selectedColor: AppTheme.primaryColor.withOpacity(0.15), checkmarkColor: AppTheme.primaryColor, labelStyle: TextStyle(color: _type == t ? AppTheme.primaryColor : AppTheme.darkSubtext, fontSize: 12))).toList()),
        const SizedBox(height: 16),
        Row(children: List.generate(5, (i) => GestureDetector(onTap: () => setState(() => _rating = i + 1), child: Icon(i < _rating ? Icons.star_rounded : Icons.star_outline_rounded, color: AppTheme.warningColor, size: 32)))),
        const SizedBox(height: 16),
        TextField(controller: _ctrl, maxLines: 5, style: const TextStyle(color: AppTheme.darkText), decoration: InputDecoration(hintText: 'Tell us more...', hintStyle: const TextStyle(color: AppTheme.darkSubtext), filled: true, fillColor: AppTheme.darkCard, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppTheme.darkBorder)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppTheme.darkBorder)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2)))),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _submitting ? null : () async {
            setState(() => _submitting = true);
            await getIt<FeedbackService>().submitFeedback(type: _type, message: _ctrl.text, rating: _rating);
            setState(() => _submitting = false);
            if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Thank you for your feedback!'), backgroundColor: AppTheme.successColor)); context.pop(); }
          },
          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, minimumSize: const Size(double.infinity, 52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
          child: _submitting ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black)) : const Text('Submit Feedback', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        ),
      ]));
  }
}
