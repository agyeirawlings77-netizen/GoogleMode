import 'package:equatable/equatable.dart';
import '../model/ai_message.dart';

abstract class AiState extends Equatable {
  const AiState();
  @override List<Object?> get props => [];
}
class AiInitial extends AiState { const AiInitial(); }
class AiLoaded extends AiState {
  final List<AiMessage> messages;
  final bool isTyping;
  const AiLoaded({required this.messages, this.isTyping = false});
  @override List<Object?> get props => [messages, isTyping];
  AiLoaded copyWith({List<AiMessage>? messages, bool? isTyping}) =>
    AiLoaded(messages: messages ?? this.messages, isTyping: isTyping ?? this.isTyping);
}
class AiError extends AiState {
  final String message;
  const AiError(this.message);
  @override List<Object?> get props => [message];
}
