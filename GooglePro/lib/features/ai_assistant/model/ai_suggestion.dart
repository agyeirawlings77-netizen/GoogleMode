class AiSuggestion {
  final String text;
  final String category;
  const AiSuggestion({required this.text, required this.category});
  static List<AiSuggestion> get defaults => const [
    AiSuggestion(text: 'What devices are currently online?', category: 'devices'),
    AiSuggestion(text: 'Help me set up parental controls', category: 'parental'),
    AiSuggestion(text: 'How do I share my screen?', category: 'screen'),
    AiSuggestion(text: 'Show me connection tips', category: 'connection'),
    AiSuggestion(text: 'How do I transfer files?', category: 'files'),
  ];
}
