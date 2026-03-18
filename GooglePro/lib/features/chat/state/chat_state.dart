import 'package:equatable/equatable.dart';
import '../model/chat_message.dart';
abstract class ChatState extends Equatable {
  const ChatState();
  @override List<Object?> get props => [];
}
class ChatInitial extends ChatState { const ChatInitial(); }
class ChatLoading extends ChatState { const ChatLoading(); }
class ChatLoaded extends ChatState {
  final List<ChatMessage> messages;
  final bool isTyping;
  final bool isSending;
  const ChatLoaded({required this.messages, this.isTyping = false, this.isSending = false});
  @override List<Object?> get props => [messages.length, isTyping, isSending];
  ChatLoaded copyWith({List<ChatMessage>? messages, bool? isTyping, bool? isSending}) =>
    ChatLoaded(messages: messages ?? this.messages, isTyping: isTyping ?? this.isTyping, isSending: isSending ?? this.isSending);
}
class ChatError extends ChatState {
  final String message;
  const ChatError(this.message);
  @override List<Object?> get props => [message];
}
