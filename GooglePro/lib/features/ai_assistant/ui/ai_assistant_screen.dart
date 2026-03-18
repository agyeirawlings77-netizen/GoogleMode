import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/ai_state.dart';
import '../state/ai_event.dart';
import '../viewmodel/ai_bloc.dart';
import '../model/ai_suggestion.dart';
import '../widget/ai_message_bubble.dart';
import '../widget/ai_suggestion_chips.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});
  @override State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  late final AiBloc _bloc;
  final _inputCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _bloc = AiBloc(getIt());
    _bloc.add(const AiInitializeEvent());
  }

  @override void dispose() { _inputCtrl.dispose(); _scrollCtrl.dispose(); _bloc.close(); super.dispose(); }

  void _send() {
    final text = _inputCtrl.text.trim();
    if (text.isEmpty) return;
    _bloc.add(AiSendMessageEvent(text));
    _inputCtrl.clear();
    setState(() => _hasText = false);
    _scrollToBottom();
  }

  void _scrollToBottom() => Future.delayed(const Duration(milliseconds: 150), () {
    if (_scrollCtrl.hasClients) _scrollCtrl.animateTo(_scrollCtrl.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: BlocListener<AiBloc, AiState>(
        listener: (ctx, state) { if (state is AiLoaded) _scrollToBottom(); },
        child: Scaffold(
          backgroundColor: AppTheme.darkBg,
          appBar: AppBar(
            backgroundColor: AppTheme.darkSurface, elevation: 0,
            leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop()),
            title: Row(children: [
              Container(width: 34, height: 34, decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [AppTheme.primaryColor, AppTheme.accentColor])), child: const Icon(Icons.auto_awesome, color: Colors.black, size: 18)),
              const SizedBox(width: 10),
              const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('GooglePro AI', style: TextStyle(color: AppTheme.darkText, fontSize: 15, fontWeight: FontWeight.w700)),
                Text('Powered by Gemini', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 11)),
              ]),
            ]),
            actions: [IconButton(icon: const Icon(Icons.refresh, color: AppTheme.darkSubtext), onPressed: () => _bloc.add(const AiClearHistoryEvent()))],
          ),
          body: Column(children: [
            Expanded(child: BlocBuilder<AiBloc, AiState>(builder: (ctx, state) {
              if (state is AiLoaded) return Column(children: [
                Expanded(child: ListView.builder(controller: _scrollCtrl, padding: const EdgeInsets.all(16), itemCount: state.messages.length, itemBuilder: (ctx, i) => AiMessageBubble(message: state.messages[i]).animate().fadeIn(delay: Duration(milliseconds: i < 5 ? i * 50 : 0)).slideY(begin: 0.1))),
                if (!state.isTyping && state.messages.length <= 2) ...[
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4), child: Align(alignment: Alignment.centerLeft, child: Text('Suggestions', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 12, fontWeight: FontWeight.w600)))),
                  AiSuggestionChips(suggestions: AiSuggestion.defaults, onSelected: (s) { _bloc.add(AiSendMessageEvent(s)); _scrollToBottom(); }),
                  const SizedBox(height: 8),
                ],
              ]);
              return const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor));
            })),

            Container(padding: const EdgeInsets.fromLTRB(16, 8, 16, 16), decoration: BoxDecoration(color: AppTheme.darkSurface, border: Border(top: BorderSide(color: AppTheme.darkBorder))),
              child: SafeArea(top: false, child: Row(children: [
                Expanded(child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppTheme.darkBorder)),
                  child: TextField(controller: _inputCtrl, style: const TextStyle(color: AppTheme.darkText, fontSize: 14), maxLines: 3, minLines: 1,
                    decoration: const InputDecoration(hintText: 'Ask GooglePro AI...', hintStyle: TextStyle(color: AppTheme.darkSubtext), border: InputBorder.none, isDense: true),
                    onChanged: (v) => setState(() => _hasText = v.trim().isNotEmpty)))),
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
