import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
class AiSuggestionBanner extends StatelessWidget {
  final String suggestion;
  final VoidCallback onTap;
  final VoidCallback onDismiss;
  const AiSuggestionBanner({super.key, required this.suggestion, required this.onTap, required this.onDismiss});
  @override
  Widget build(BuildContext context) {
    return Container(margin: const EdgeInsets.only(bottom: 16), padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.08), borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.primaryColor.withOpacity(0.2))),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(6), decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [AppTheme.primaryColor, AppTheme.accentColor])), child: const Icon(Icons.auto_awesome, color: Colors.black, size: 14)),
        const SizedBox(width: 10),
        Expanded(child: GestureDetector(onTap: onTap, child: Text(suggestion, style: const TextStyle(color: AppTheme.darkText, fontSize: 13, height: 1.4)))),
        IconButton(icon: const Icon(Icons.close, color: AppTheme.darkSubtext, size: 16), padding: EdgeInsets.zero, constraints: const BoxConstraints(), onPressed: onDismiss),
      ])).animate().fadeIn().slideY(begin: -0.1);
  }
}
