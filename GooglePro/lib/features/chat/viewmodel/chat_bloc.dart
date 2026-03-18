import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/chat_service.dart';
import '../state/chat_state.dart';
import '../state/chat_event.dart';
import '../../../core/utils/app_logger.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatService _svc;
  String? _sessionId;
  StreamSubscription? _msgSub;

  ChatBloc(this._svc) : super(const ChatInitial()) {
    on<LoadChatEvent>(_onLoad);
    on<SendMessageEvent>(_onSend);
    on<SetTypingEvent>((e, emit) { if (_sessionId != null) _svc.setTyping(_sessionId!, e.typing); });
    on<MarkReadEvent>((e, emit) { if (_sessionId != null) _svc.markRead(_sessionId!); });
  }

  Future<void> _onLoad(LoadChatEvent e, Emitter<ChatState> emit) async {
    _sessionId = e.sessionId;
    emit(const ChatLoading());
    try {
      final msgs = await _svc.getMessages(e.sessionId);
      emit(ChatLoaded(messages: msgs));
      _msgSub?.cancel();
      _msgSub = _svc.watchMessages(e.sessionId).listen((messages) {
        if (state is ChatLoaded) emit((state as ChatLoaded).copyWith(messages: messages));
      });
    } catch (err, s) { AppLogger.error('Chat load failed', err, s); emit(ChatError(err.toString())); }
  }

  Future<void> _onSend(SendMessageEvent e, Emitter<ChatState> emit) async {
    if (_sessionId == null || e.text.trim().isEmpty) return;
    if (state is ChatLoaded) emit((state as ChatLoaded).copyWith(isSending: true));
    try {
      await _svc.sendMessage(sessionId: _sessionId!, text: e.text.trim());
      if (state is ChatLoaded) emit((state as ChatLoaded).copyWith(isSending: false));
    } catch (err) {
      AppLogger.error('Send message failed', err);
      if (state is ChatLoaded) emit((state as ChatLoaded).copyWith(isSending: false));
    }
  }

  @override Future<void> close() async { await _msgSub?.cancel(); return super.close(); }
}
