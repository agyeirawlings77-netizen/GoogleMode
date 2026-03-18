import 'package:equatable/equatable.dart';
abstract class ChatEvent extends Equatable {
  const ChatEvent();
  @override List<Object?> get props => [];
}
class LoadChatEvent extends ChatEvent {
  final String sessionId;
  const LoadChatEvent(this.sessionId);
  @override List<Object?> get props => [sessionId];
}
class SendMessageEvent extends ChatEvent {
  final String text;
  const SendMessageEvent(this.text);
  @override List<Object?> get props => [text];
}
class SetTypingEvent extends ChatEvent {
  final bool typing;
  const SetTypingEvent(this.typing);
  @override List<Object?> get props => [typing];
}
class MarkReadEvent extends ChatEvent { const MarkReadEvent(); }
