import 'package:flutter/material.dart';
import '../model/ai_suggestion.dart';
import '../../../core/theme/app_theme.dart';

class AiSuggestionChips extends StatelessWidget {
  final List<AiSuggestion> suggestions;
  final ValueChanged<String> onSelected;
  const AiSuggestionChips({super.key, required this.suggestions, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 40,
      child: ListView.builder(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: suggestions.length, itemBuilder: (ctx, i) {
        return GestureDetector(
          onTap: () => onSelected(suggestions[i].text),
          child: Container(margin: const EdgeInsets.only(right: 8), padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20), border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3))),
            child: Text(suggestions[i].text, style: const TextStyle(color: AppTheme.primaryColor, fontSize: 12, fontWeight: FontWeight.w500))));
      }));
  }
}
