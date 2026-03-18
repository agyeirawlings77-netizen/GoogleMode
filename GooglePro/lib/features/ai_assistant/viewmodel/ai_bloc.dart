import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/gemini_service.dart';
import '../model/ai_message.dart';
import '../state/ai_state.dart';
import '../state/ai_event.dart';
import '../../../core/utils/app_logger.dart';

class AiBloc extends Bloc<AiEvent, AiState> {
  final GeminiService _gemini;

  AiBloc(this._gemini) : super(const AiInitial()) {
    on<AiInitializeEvent>(_onInit);
    on<AiSendMessageEvent>(_onSend);
    on<AiClearHistoryEvent>(_onClear);
    on<AiUseSuggestionEvent>(_onSuggestion);
  }

  void _onInit(AiInitializeEvent e, Emitter<AiState> emit) {
    final welcome = AiMessage.assistant('Hello! I\'m GooglePro AI, powered by Gemini. How can I help you today?\n\nI can assist with screen sharing, device management, parental controls, security settings, and more.');
    emit(AiLoaded(messages: [welcome]));
  }

  Future<void> _onSend(AiSendMessageEvent e, Emitter<AiState> emit) async {
    if (e.message.trim().isEmpty) return;
    final current = state is AiLoaded ? (state as AiLoaded).messages : <AiMessage>[];
    final userMsg = AiMessage.user(e.message);
    final loadingMsg = AiMessage.loading();
    emit(AiLoaded(messages: [...current, userMsg, loadingMsg], isTyping: true));
    try {
      final response = await _gemini.sendMessage(e.message);
      final messages = [...current, userMsg];
      emit(AiLoaded(messages: [...messages, AiMessage.assistant(response)], isTyping: false));
    } catch (err, s) {
      AppLogger.error('AI send failed', err, s);
      emit(AiLoaded(messages: [...current, userMsg, AiMessage.assistant('Sorry, I encountered an error. Please try again.')], isTyping: false));
    }
  }

  void _onClear(AiClearHistoryEvent e, Emitter<AiState> emit) {
    _gemini.resetChat();
    _onInit(const AiInitializeEvent(), emit);
  }

  void _onSuggestion(AiUseSuggestionEvent e, Emitter<AiState> emit) =>
    add(AiSendMessageEvent(e.suggestion));
}
