import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/chat_state.dart';
import '../state/chat_event.dart';
import '../viewmodel/chat_bloc.dart';
import '../widget/message_bubble.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class ChatScreen extends StatefulWidget {
  final String deviceId;
  final String deviceName;
  const ChatScreen({super.key, required this.deviceId, required this.deviceName});
  @override State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ChatBloc _bloc;
  final _inputCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _bloc = ChatBloc(getIt())..add(LoadChatEvent(widget.deviceId));
  }
  @override void dispose() { _inputCtrl.dispose(); _scrollCtrl.dispose(); _bloc.close(); super.dispose(); }

  void _scrollToBottom() => Future.delayed(const Duration(milliseconds: 100), () { if (_scrollCtrl.hasClients) _scrollCtrl.animateTo(_scrollCtrl.position.maxScrollExtent, duration: const Duration(milliseconds: 250), curve: Curves.easeOut); });

  void _send() {
    if (_inputCtrl.text.trim().isEmpty) return;
    _bloc.add(SendMessageEvent(_inputCtrl.text.trim()));
    _inputCtrl.clear();
    setState(() => _hasText = false);
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: BlocListener<ChatBloc, ChatState>(
        listener: (ctx, state) { if (state is ChatLoaded) _scrollToBottom(); },
        child: Scaffold(
          backgroundColor: AppTheme.darkBg,
          appBar: AppBar(backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop()),
            title: Row(children: [
              CircleAvatar(radius: 16, backgroundColor: AppTheme.primaryColor.withOpacity(0.15), child: Text(widget.deviceName.isNotEmpty ? widget.deviceName[0].toUpperCase() : '?', style: const TextStyle(color: AppTheme.primaryColor, fontSize: 12, fontWeight: FontWeight.w700))),
              const SizedBox(width: 8),
              Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                Text(widget.deviceName, style: const TextStyle(color: AppTheme.darkText, fontSize: 15, fontWeight: FontWeight.w700)),
                const Text('Online', style: TextStyle(color: AppTheme.successColor, fontSize: 11)),
              ]),
            ])),
          body: Column(children: [
            Expanded(child: BlocBuilder<ChatBloc, ChatState>(builder: (ctx, state) {
              if (state is ChatLoading) return const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor));
              if (state is ChatLoaded) {
                if (state.messages.isEmpty) return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.chat_bubble_outline, color: AppTheme.darkSubtext, size: 48).animate().scale(), const SizedBox(height: 12), const Text('No messages yet', style: TextStyle(color: AppTheme.darkSubtext)), const Text('Send a message to start the conversation.', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 12))]));
                return ListView.builder(controller: _scrollCtrl, padding: const EdgeInsets.all(16), itemCount: state.messages.length + (state.isTyping ? 1 : 0), itemBuilder: (ctx, i) {
                  if (i == state.messages.length) return Padding(padding: const EdgeInsets.only(left: 12), child: Row(children: [Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10), decoration: const BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18), bottomRight: Radius.circular(18), bottomLeft: Radius.circular(4))), child: Row(mainAxisSize: MainAxisSize.min, children: List.generate(3, (i) => Container(width: 5, height: 5, margin: const EdgeInsets.only(right: 3), decoration: const BoxDecoration(shape: BoxShape.circle, color: AppTheme.darkSubtext)).animate(delay: Duration(milliseconds: i * 200), onPlay: (c) => c.repeat(reverse: true)).scaleXY(begin: 0.5, end: 1.0))))]));
                  return MessageBubble(message: state.messages[i], index: i);
                });
              }
              return const SizedBox.shrink();
            })),

            // Input bar
            Container(padding: const EdgeInsets.fromLTRB(12, 8, 12, 12), decoration: BoxDecoration(color: AppTheme.darkSurface, border: Border(top: BorderSide(color: AppTheme.darkBorder))),
              child: SafeArea(top: false, child: Row(children: [
                Expanded(child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppTheme.darkBorder)),
                  child: TextField(controller: _inputCtrl, style: const TextStyle(color: AppTheme.darkText, fontSize: 14), maxLines: 4, minLines: 1, textInputAction: TextInputAction.send, onSubmitted: (_) => _send(),
                    onChanged: (v) { setState(() => _hasText = v.trim().isNotEmpty); _bloc.add(SetTypingEvent(v.isNotEmpty)); },
                    decoration: const InputDecoration(hintText: 'Type a message...', hintStyle: TextStyle(color: AppTheme.darkSubtext), border: InputBorder.none, isDense: true)))),
                const SizedBox(width: 8),
                AnimatedContainer(duration: const Duration(milliseconds: 200), width: 44, height: 44,
                  decoration: BoxDecoration(shape: BoxShape.circle, gradient: _hasText ? const LinearGradient(colors: [AppTheme.primaryColor, AppTheme.accentColor]) : null, color: _hasText ? null : AppTheme.darkBorder),
                  child: IconButton(icon: const Icon(Icons.send_rounded, size: 18), color: _hasText ? Colors.black : AppTheme.darkSubtext, onPressed: _hasText ? _send : null)),
              ]))),
          ]),
        ),
      ),
    );
  }
}
