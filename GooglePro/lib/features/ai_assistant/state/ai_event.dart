import 'package:equatable/equatable.dart';
abstract class AiEvent extends Equatable {
  const AiEvent();
  @override List<Object?> get props => [];
}
class AiInitializeEvent extends AiEvent { const AiInitializeEvent(); }
class AiSendMessageEvent extends AiEvent {
  final String message;
  const AiSendMessageEvent(this.message);
  @override List<Object?> get props => [message];
}
class AiClearHistoryEvent extends AiEvent { const AiClearHistoryEvent(); }
class AiUseSuggestionEvent extends AiEvent {
  final String suggestion;
  const AiUseSuggestionEvent(this.suggestion);
  @override List<Object?> get props => [suggestion];
}
