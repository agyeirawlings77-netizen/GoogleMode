import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/dashboard_state.dart';
import '../state/dashboard_event.dart';
import '../viewmodel/dashboard_bloc.dart';
import '../widget/device_card.dart';
import '../widget/stats_row.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final DashboardBloc _bloc;
  @override void initState() { super.initState(); _bloc = DashboardBloc(getIt())..add(const LoadDashboardEvent()); }
  @override void dispose() { _bloc.close(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return BlocProvider.value(value: _bloc,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        body: SafeArea(child: RefreshIndicator(color: AppTheme.primaryColor, backgroundColor: AppTheme.darkCard, onRefresh: () async => _bloc.add(const LoadDashboardEvent()),
          child: CustomScrollView(slivers: [
            // App bar
            SliverAppBar(
              floating: true, pinned: false, expandedHeight: 0,
              backgroundColor: AppTheme.darkBg, elevation: 0,
              title: Row(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                  Text('Hello, ${user?.displayName?.split(' ').first ?? 'User'} 👋', style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 13)),
                  const Text('GooglePro', style: TextStyle(color: AppTheme.darkText, fontSize: 20, fontWeight: FontWeight.w800)),
                ]),
              ]),
              actions: [
                // Notification bell
                BlocBuilder<DashboardBloc, DashboardState>(builder: (ctx, state) {
                  return Stack(children: [
                    IconButton(icon: const Icon(Icons.notifications_outlined, color: AppTheme.darkText), onPressed: () => context.push('/notifications')),
                  ]);
                }),
                // AI button
                Container(margin: const EdgeInsets.only(right: 8), child: Material(color: AppTheme.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10), child: InkWell(onTap: () => context.push('/ai-assistant'), borderRadius: BorderRadius.circular(10), child: const Padding(padding: EdgeInsets.all(8), child: Icon(Icons.auto_awesome, color: AppTheme.primaryColor, size: 22))))),
                // Avatar
                GestureDetector(onTap: () => context.push('/settings'), child: Container(margin: const EdgeInsets.only(right: 16), child: CircleAvatar(radius: 18, backgroundColor: AppTheme.primaryColor.withOpacity(0.15), backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null, child: user?.photoURL == null ? Text(user?.displayName?.isNotEmpty == true ? user!.displayName![0].toUpperCase() : 'G', style: const TextStyle(color: AppTheme.primaryColor, fontSize: 14, fontWeight: FontWeight.w700)) : null))),
              ],
            ),

            SliverPadding(padding: const EdgeInsets.symmetric(horizontal: 16), sliver: SliverList(delegate: SliverChildListDelegate([
              // Stats
              BlocBuilder<DashboardBloc, DashboardState>(builder: (ctx, state) {
                if (state is DashboardLoaded) return Padding(padding: const EdgeInsets.only(bottom: 20), child: StatsRow(stats: state.stats));
                return const SizedBox(height: 80);
              }).animate().fadeIn(),

              // Quick actions
              const Padding(padding: EdgeInsets.only(bottom: 12), child: Text('QUICK ACTIONS', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2))),
              _quickActionsGrid(context),
              const SizedBox(height: 24),

              // Devices section
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('YOUR DEVICES', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
                TextButton(onPressed: () => context.push('/devices'), child: const Text('Manage', style: TextStyle(color: AppTheme.primaryColor, fontSize: 13))),
              ]),
              const SizedBox(height: 8),

              BlocBuilder<DashboardBloc, DashboardState>(builder: (ctx, state) {
                if (state is DashboardLoading) return Column(children: List.generate(2, (i) => Container(height: 80, margin: const EdgeInsets.only(bottom: 12), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(18)))));
                if (state is DashboardLoaded) {
                  if (state.devices.isEmpty) return _emptyDevices(context);
                  return Column(children: state.devices.asMap().entries.map((e) => DeviceCard(device: e.value, index: e.key, onTap: () => context.push('/device/${e.value.deviceId}', extra: e.value), onConnect: () => context.push('/session/${e.value.deviceId}'))).toList());
                }
                if (state is DashboardError) return Container(padding: const EdgeInsets.all(20), child: Text('Error: ${state.message}', style: const TextStyle(color: AppTheme.errorColor)));
                return const SizedBox.shrink();
              }),
              const SizedBox(height: 32),
            ]))),
          ]),
        )),

        // FAB — Add Device
        floatingActionButton: FloatingActionButton.extended(onPressed: () => context.push('/qr-pairing'), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, icon: const Icon(Icons.add_rounded), label: const Text('Add Device', style: TextStyle(fontWeight: FontWeight.w700))),
      ),
    );
  }

  Widget _quickActionsGrid(BuildContext context) {
    final actions = [
      {'icon': Icons.screen_share_rounded, 'label': 'Screen Share', 'color': AppTheme.primaryColor, 'route': '/devices'},
      {'icon': Icons.touch_app_rounded, 'label': 'Remote Control', 'color': const Color(0xFF7C4DFF), 'route': '/devices'},
      {'icon': Icons.folder_open_rounded, 'label': 'File Transfer', 'color': AppTheme.accentColor, 'route': '/devices'},
      {'icon': Icons.child_care_rounded, 'label': 'Parental', 'color': const Color(0xFFFF6D00), 'route': '/devices'},
      {'icon': Icons.mic_rounded, 'label': 'Voice Call', 'color': const Color(0xFF00BFA5), 'route': '/devices'},
      {'icon': Icons.location_on_rounded, 'label': 'Location', 'color': AppTheme.errorColor, 'route': '/devices'},
    ];
    return GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1.1),
      itemCount: actions.length,
      itemBuilder: (ctx, i) {
        final a = actions[i];
        return GestureDetector(onTap: () => context.push(a['route'] as String),
          child: Container(decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.darkBorder)),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: (a['color'] as Color).withOpacity(0.1), shape: BoxShape.circle), child: Icon(a['icon'] as IconData, color: a['color'] as Color, size: 22)),
              const SizedBox(height: 8),
              Text(a['label'] as String, style: const TextStyle(color: AppTheme.darkText, fontSize: 11, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
            ])).animate().fadeIn(delay: Duration(milliseconds: i * 60)));
      });
  }

  Widget _emptyDevices(BuildContext context) {
    return Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppTheme.darkBorder)),
      child: Column(children: [
        const Icon(Icons.devices_outlined, color: AppTheme.darkSubtext, size: 48),
        const SizedBox(height: 12),
        const Text('No devices yet', style: TextStyle(color: AppTheme.darkText, fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        const Text('Tap the + button to add your first device using QR code.', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.darkSubtext, fontSize: 13, height: 1.5)),
        const SizedBox(height: 16),
        ElevatedButton.icon(onPressed: () => context.push('/qr-pairing'), icon: const Icon(Icons.qr_code_scanner, color: Colors.black, size: 18), label: const Text('Scan QR Code', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)), style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
      ]));
  }
}
