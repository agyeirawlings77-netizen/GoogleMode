import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/theme_state.dart';
import '../state/theme_event.dart';
import '../viewmodel/theme_bloc.dart';
import '../model/app_theme_model.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class ThemeSettingsScreen extends StatefulWidget {
  const ThemeSettingsScreen({super.key});
  @override State<ThemeSettingsScreen> createState() => _ThemeSettingsScreenState();
}

class _ThemeSettingsScreenState extends State<ThemeSettingsScreen> {
  late final ThemeBloc _bloc;
  @override void initState() { super.initState(); _bloc = ThemeBloc(getIt()); _bloc.add(const LoadThemeEvent()); }
  @override void dispose() { _bloc.close(); super.dispose(); }

  static const _accentColors = {
    AccentColor.cyan: Color(0xFF00C2FF), AccentColor.green: Color(0xFF00FF94),
    AccentColor.purple: Color(0xFF7C4DFF), AccentColor.orange: Color(0xFFFF6D00),
    AccentColor.red: Color(0xFFFF4D4D), AccentColor.pink: Color(0xFFFF4081),
  };

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(title: const Text('Theme', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
        body: BlocBuilder<ThemeBloc, ThemeState>(builder: (ctx, state) {
          if (state is! ThemeLoaded) return const SizedBox.shrink();
          final m = state.themeModel;
          return ListView(padding: const EdgeInsets.all(20), children: [
            const Text('MODE', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
            const SizedBox(height: 10),
            Row(children: [
              _modeBtn('System', Icons.brightness_auto, ThemeMode2.system, m.mode),
              const SizedBox(width: 8),
              _modeBtn('Light', Icons.light_mode, ThemeMode2.light, m.mode),
              const SizedBox(width: 8),
              _modeBtn('Dark', Icons.dark_mode, ThemeMode2.dark, m.mode),
            ]).animate().fadeIn(),
            const SizedBox(height: 24),
            const Text('ACCENT COLOR', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
            const SizedBox(height: 10),
            Wrap(spacing: 12, runSpacing: 12,
              children: _accentColors.entries.map((e) => GestureDetector(
                onTap: () => _bloc.add(ChangeAccentColorEvent(e.key)),
                child: AnimatedContainer(duration: const Duration(milliseconds: 200), width: 48, height: 48, decoration: BoxDecoration(shape: BoxShape.circle, color: e.value, border: Border.all(color: m.accent == e.key ? Colors.white : Colors.transparent, width: 3), boxShadow: m.accent == e.key ? [BoxShadow(color: e.value.withOpacity(0.5), blurRadius: 12, spreadRadius: 2)] : null)),
              )).toList()).animate().fadeIn(delay: 100.ms),
            const SizedBox(height: 24),
            const Text('OPTIONS', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
            const SizedBox(height: 10),
            Container(decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.darkBorder)),
              child: SwitchListTile(title: const Text('True Black (AMOLED)', style: TextStyle(color: AppTheme.darkText)), subtitle: const Text('Pure black background', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 12)), value: m.trueBlack, onChanged: (v) => _bloc.add(ToggleTrueBlackEvent(v)), activeColor: AppTheme.primaryColor)),
          ]);
        }),
      ),
    );
  }

  Widget _modeBtn(String label, IconData icon, ThemeMode2 mode, ThemeMode2 selected) {
    final isSelected = mode == selected;
    return Expanded(child: GestureDetector(onTap: () => _bloc.add(ChangeThemeModeEvent(mode)),
      child: AnimatedContainer(duration: const Duration(milliseconds: 200), padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(color: isSelected ? AppTheme.primaryColor.withOpacity(0.15) : AppTheme.darkCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: isSelected ? AppTheme.primaryColor.withOpacity(0.4) : AppTheme.darkBorder)),
        child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: isSelected ? AppTheme.primaryColor : AppTheme.darkSubtext, size: 22), const SizedBox(height: 4), Text(label, style: TextStyle(color: isSelected ? AppTheme.primaryColor : AppTheme.darkSubtext, fontSize: 12, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal))]))));
  }
}
