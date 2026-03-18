import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/device_info_model.dart';
import '../../../core/theme/app_theme.dart';
class DeviceInfoScreen extends StatelessWidget {
  final DeviceInfoModel info;
  const DeviceInfoScreen({super.key, required this.info});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppTheme.darkBg,
      appBar: AppBar(title: const Text('Device Info', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        _section('System', [_row('Manufacturer', info.manufacturer), _row('Model', info.model), _row('Android', info.osVersion), _row('App Version', info.appVersion)]),
        const SizedBox(height: 16),
        _section('Battery', [_row('Level', '${info.batteryLevel}%'), _row('Charging', info.isCharging ? 'Yes' : 'No')]),
        const SizedBox(height: 16),
        _section('Network', [_row('Type', info.networkType ?? 'N/A'), _row('IP Address', info.ipAddress ?? 'N/A')]),
      ]),
    );
  }
  Widget _section(String title, List<Widget> rows) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1)),
    const SizedBox(height: 6),
    Container(decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.darkBorder)), child: Column(children: rows)),
  ]);
  Widget _row(String l, String v) => Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), child: Row(children: [Text(l, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 13)), const Spacer(), Text(v, style: const TextStyle(color: AppTheme.darkText, fontSize: 13, fontWeight: FontWeight.w500))]));
}
