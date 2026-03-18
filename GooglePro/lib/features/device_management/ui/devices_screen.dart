import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/device_state.dart';
import '../state/device_event.dart';
import '../viewmodel/device_bloc.dart';
import '../widget/device_list_tile.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key});
  @override State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  late final DeviceBloc _bloc;
  String _search = '';
  @override void initState() { super.initState(); _bloc = DeviceBloc(getIt())..add(const LoadDevicesEvent()); }
  @override void dispose() { _bloc.close(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(
          title: const Text('Devices', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)),
          backgroundColor: AppTheme.darkSurface, elevation: 0,
          leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop()),
          actions: [
            IconButton(icon: const Icon(Icons.qr_code_scanner, color: AppTheme.primaryColor), onPressed: () => context.push('/qr-pairing')),
            IconButton(icon: const Icon(Icons.verified_outlined, color: AppTheme.darkText), onPressed: () => context.push('/trusted-devices')),
          ],
        ),
        body: Column(children: [
          // Search bar
          Padding(padding: const EdgeInsets.all(16), child: TextField(onChanged: (v) => setState(() => _search = v.toLowerCase()), style: const TextStyle(color: AppTheme.darkText), decoration: InputDecoration(hintText: 'Search devices...', hintStyle: const TextStyle(color: AppTheme.darkSubtext), prefixIcon: const Icon(Icons.search, color: AppTheme.darkSubtext, size: 20), filled: true, fillColor: AppTheme.darkCard, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.darkBorder)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.darkBorder)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2))))),

          Expanded(child: BlocBuilder<DeviceBloc, DeviceState>(builder: (ctx, state) {
            if (state is DeviceLoading) return const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor));
            if (state is DeviceLoaded) {
              final filtered = _search.isEmpty ? state.devices : state.devices.where((d) => d.deviceName.toLowerCase().contains(_search)).toList();
              if (filtered.isEmpty) return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.devices_outlined, color: AppTheme.darkSubtext, size: 52),
                const SizedBox(height: 12),
                Text(_search.isEmpty ? 'No devices yet' : 'No devices match "$_search"', style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 15)),
                if (_search.isEmpty) ...[const SizedBox(height: 16), ElevatedButton.icon(onPressed: () => context.push('/qr-pairing'), icon: const Icon(Icons.qr_code_scanner, color: Colors.black, size: 18), label: const Text('Add Device', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)), style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))))],
              ]));
              return RefreshIndicator(onRefresh: () async => _bloc.add(const LoadDevicesEvent()), color: AppTheme.primaryColor, child: ListView.builder(padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: filtered.length, itemBuilder: (ctx, i) => DeviceListTile(device: filtered[i], index: i, onConnect: () => context.push('/session/${filtered[i].deviceId}'), onMoreOptions: () => _showOptions(context, filtered[i].deviceId, filtered[i].deviceName)).animate().fadeIn(delay: Duration(milliseconds: i * 60))));
            }
            if (state is DeviceError) return Center(child: Text('Error: ${state.message}', style: const TextStyle(color: AppTheme.errorColor)));
            return const SizedBox.shrink();
          })),
        ]),
        floatingActionButton: FloatingActionButton(onPressed: () => context.push('/qr-pairing'), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, child: const Icon(Icons.add_rounded)),
      ),
    );
  }

  void _showOptions(BuildContext context, String deviceId, String deviceName) {
    showModalBottomSheet(context: context, backgroundColor: AppTheme.darkCard, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))), builder: (_) => Padding(padding: const EdgeInsets.all(20), child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 40, height: 4, decoration: BoxDecoration(color: AppTheme.darkBorder, borderRadius: BorderRadius.circular(2)), margin: const EdgeInsets.only(bottom: 20)),
      Text(deviceName, style: const TextStyle(color: AppTheme.darkText, fontSize: 16, fontWeight: FontWeight.w700)),
      const SizedBox(height: 16),
      ListTile(leading: const Icon(Icons.edit_outlined, color: AppTheme.primaryColor), title: const Text('Rename', style: TextStyle(color: AppTheme.darkText)), onTap: () { Navigator.pop(context); _showRename(context, deviceId); }),
      ListTile(leading: const Icon(Icons.child_care_rounded, color: Colors.orange), title: const Text('Parental Controls', style: TextStyle(color: AppTheme.darkText)), onTap: () { Navigator.pop(context); context.push('/parental-controls/$deviceId'); }),
      ListTile(leading: const Icon(Icons.location_on_outlined, color: AppTheme.errorColor), title: const Text('Track Location', style: TextStyle(color: AppTheme.darkText)), onTap: () { Navigator.pop(context); context.push('/location/$deviceId'); }),
      ListTile(leading: const Icon(Icons.delete_outline, color: AppTheme.errorColor), title: const Text('Remove Device', style: TextStyle(color: AppTheme.errorColor)), onTap: () { Navigator.pop(context); _bloc.add(DeleteDeviceEvent(deviceId)); }),
    ])));
  }

  void _showRename(BuildContext context, String deviceId) {
    final ctrl = TextEditingController();
    showDialog(context: context, builder: (_) => AlertDialog(backgroundColor: AppTheme.darkCard, title: const Text('Rename Device', style: TextStyle(color: AppTheme.darkText)), content: TextField(controller: ctrl, style: const TextStyle(color: AppTheme.darkText), decoration: InputDecoration(hintText: 'Device name', hintStyle: const TextStyle(color: AppTheme.darkSubtext), filled: true, fillColor: AppTheme.darkBorder, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none))), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(color: AppTheme.darkSubtext))), TextButton(onPressed: () { _bloc.add(RenameDeviceEvent(deviceId, ctrl.text.trim())); Navigator.pop(context); }, child: const Text('Save', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.w700)))]));
  }
}
