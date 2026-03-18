enum AiMessageRole { user, assistant, system }

class AiMessage {
  final String messageId;
  final AiMessageRole role;
  final String content;
  final DateTime timestamp;
  final bool isLoading;

  const AiMessage({required this.messageId, required this.role, required this.content, required this.timestamp, this.isLoading = false});

  factory AiMessage.user(String content) => AiMessage(messageId: DateTime.now().millisecondsSinceEpoch.toString(), role: AiMessageRole.user, content: content, timestamp: DateTime.now());
  factory AiMessage.assistant(String content, {bool isLoading = false}) => AiMessage(messageId: '${DateTime.now().millisecondsSinceEpoch}_ai', role: AiMessageRole.assistant, content: content, timestamp: DateTime.now(), isLoading: isLoading);
  factory AiMessage.loading() => AiMessage.assistant('', isLoading: true);
}
