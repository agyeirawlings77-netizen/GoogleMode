import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/settings_event.dart';
import '../state/settings_state.dart';
import '../viewmodel/settings_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({super.key});
  @override State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  late final SettingsBloc _bloc;
  final _languages = const [
    {'code': 'en', 'name': 'English', 'native': 'English'},
    {'code': 'fr', 'name': 'French', 'native': 'Français'},
    {'code': 'es', 'name': 'Spanish', 'native': 'Español'},
    {'code': 'ar', 'name': 'Arabic', 'native': 'العربية'},
    {'code': 'pt', 'name': 'Portuguese', 'native': 'Português'},
    {'code': 'hi', 'name': 'Hindi', 'native': 'हिन्दी'},
    {'code': 'yo', 'name': 'Yoruba', 'native': 'Yorùbá'},
    {'code': 'zh', 'name': 'Chinese', 'native': '中文'},
    {'code': 'de', 'name': 'German', 'native': 'Deutsch'},
    {'code': 'ja', 'name': 'Japanese', 'native': '日本語'},
  ];
  String _selected = 'en';

  @override
  void initState() {
    super.initState();
    _bloc = SettingsBloc(getIt());
    _bloc.add(const LoadSettingsEvent());
  }

  @override void dispose() { _bloc.close(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: BlocListener<SettingsBloc, SettingsState>(
        listener: (ctx, state) { if (state is SettingsLoaded) setState(() => _selected = state.settings.language); },
        child: Scaffold(
          backgroundColor: AppTheme.darkBg,
          appBar: AppBar(title: const Text('Language', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0,
            leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _languages.length,
            itemBuilder: (ctx, i) {
              final lang = _languages[i];
              final code = lang['code']!;
              final isSelected = _selected == code;
              return Container(margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: isSelected ? AppTheme.primaryColor.withOpacity(0.4) : AppTheme.darkBorder)),
                child: ListTile(
                  title: Text(lang['native']!, style: TextStyle(color: isSelected ? AppTheme.primaryColor : AppTheme.darkText, fontWeight: FontWeight.w600)),
                  subtitle: Text(lang['name']!, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 12)),
                  trailing: isSelected ? const Icon(Icons.check_circle, color: AppTheme.primaryColor) : null,
                  onTap: () {
                    setState(() => _selected = code);
                    _bloc.add(ChangeLanguageEvent(code));
                  },
                ));
            },
          ),
        ),
      ),
    );
  }
}
