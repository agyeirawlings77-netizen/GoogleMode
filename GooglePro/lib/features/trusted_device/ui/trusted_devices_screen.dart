import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../auto_connect/model/trusted_devices_state.dart';
import '../../auto_connect/model/trusted_devices_event.dart';
import '../../auto_connect/viewmodel/trusted_devices_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class TrustedDevicesScreen extends StatefulWidget {
  const TrustedDevicesScreen({super.key});
  @override State<TrustedDevicesScreen> createState() => _TrustedDevicesScreenState();
}

class _TrustedDevicesScreenState extends State<TrustedDevicesScreen> {
  late final TrustedDevicesBloc _bloc;
  @override void initState() { super.initState(); _bloc = TrustedDevicesBloc(getIt())..add(const LoadTrustedDevicesEvent()); }
  @override void dispose() { _bloc.close(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(title: const Text('Trusted Devices', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
        body: BlocBuilder<TrustedDevicesBloc, TrustedDevicesState>(builder: (ctx, state) {
          if (state is TrustedDevicesEmpty) return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.verified_outlined, color: AppTheme.darkSubtext, size: 56).animate().scale(),
            const SizedBox(height: 16),
            const Text('No trusted devices', style: TextStyle(color: AppTheme.darkText, fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Text('Pair a device via QR code\nand it will appear here.', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.darkSubtext, height: 1.5)),
            const SizedBox(height: 24),
            ElevatedButton.icon(onPressed: () => context.push('/qr-pairing'), icon: const Icon(Icons.qr_code_scanner, color: Colors.black, size: 18), label: const Text('Pair Device', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)), style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
          ]));

          if (state is TrustedDevicesLoaded) return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.devices.length,
            itemBuilder: (ctx, i) {
              final d = state.devices[i];
              return Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: d.autoConnect ? AppTheme.primaryColor.withOpacity(0.3) : AppTheme.darkBorder)),
                child: Row(children: [
                  Container(width: 44, height: 44, decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.verified_rounded, color: AppTheme.primaryColor, size: 22)),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(d.deviceName, style: const TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w600)),
                    Text('Paired ${_ago(d.pairedAt)}', style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 11)),
                  ])),
                  Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.end, children: [
                    const Text('Auto-connect', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 10)),
                    Switch(value: d.autoConnect, onChanged: (v) => _bloc.add(ToggleAutoConnectEvent(d.deviceId, v)), activeColor: AppTheme.primaryColor),
                  ]),
                  PopupMenuButton<String>(icon: const Icon(Icons.more_vert, color: AppTheme.darkSubtext, size: 18), color: AppTheme.darkCard, onSelected: (v) { if (v == 'remove') _bloc.add(RemoveTrustedDeviceEvent(d.deviceId)); }, itemBuilder: (_) => [const PopupMenuItem(value: 'remove', child: Text('Remove', style: TextStyle(color: AppTheme.errorColor)))]),
                ])).animate().fadeIn(delay: Duration(milliseconds: i * 60));
            });
          return const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor));
        }),
      ),
    );
  }

  String _ago(DateTime dt) { final d = DateTime.now().difference(dt); if (d.inDays > 0) return '${d.inDays}d ago'; if (d.inHours > 0) return '${d.inHours}h ago'; return 'just now'; }
}
