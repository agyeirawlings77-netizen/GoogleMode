import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../state/device_management_state.dart';
import '../state/device_management_event.dart';
import '../viewmodel/device_management_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class QrPairingScreen extends StatefulWidget {
  const QrPairingScreen({super.key});
  @override State<QrPairingScreen> createState() => _QrPairingScreenState();
}

class _QrPairingScreenState extends State<QrPairingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabs;
  late final DeviceManagementBloc _bloc;
  bool _scanned = false;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
    _bloc = DeviceManagementBloc(getIt(), getIt());
    _bloc.add(const GenerateQrCodeEvent());
  }

  @override
  void dispose() { _tabs.dispose(); _bloc.close(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: BlocListener<DeviceManagementBloc, DeviceManagementState>(
        listener: (ctx, state) {
          if (state is DevicePaired) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Paired: ${state.device.deviceName}'), backgroundColor: AppTheme.successColor));
            context.go('/trusted-devices');
          }
          if (state is DeviceManagementError) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: AppTheme.errorColor));
        },
        child: Scaffold(
          backgroundColor: AppTheme.darkBg,
          appBar: AppBar(title: const Text('Pair Device', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0,
            leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop()),
            bottom: TabBar(controller: _tabs, indicatorColor: AppTheme.primaryColor, labelColor: AppTheme.primaryColor, unselectedLabelColor: AppTheme.darkSubtext, tabs: const [Tab(text: 'My QR Code'), Tab(text: 'Scan QR')])),
          body: TabBarView(controller: _tabs, children: [
            _buildShowQr(),
            _buildScanQr(),
          ]),
        ),
      ),
    );
  }

  Widget _buildShowQr() {
    return BlocBuilder<DeviceManagementBloc, DeviceManagementState>(builder: (ctx, state) {
      return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Share this QR code', style: TextStyle(color: AppTheme.darkText, fontSize: 18, fontWeight: FontWeight.w600)).animate().fadeIn(),
        const SizedBox(height: 8),
        const Text('Let another device scan to pair', style: TextStyle(color: AppTheme.darkSubtext)).animate().fadeIn(delay: 100.ms),
        const SizedBox(height: 32),
        if (state is QrCodeGenerated)
          Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: QrImageView(data: state.qrData, version: QrVersions.auto, size: 220, eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: Colors.black), dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: Colors.black)))
          .animate().scale(duration: 400.ms, curve: Curves.elasticOut)
        else const CircularProgressIndicator(color: AppTheme.primaryColor),
        const SizedBox(height: 24),
        const Text('Valid for 5 minutes', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 12)),
      ]));
    });
  }

  Widget _buildScanQr() {
    return Stack(children: [
      MobileScanner(
        onDetect: (capture) {
          if (_scanned) return;
          final barcode = capture.barcodes.firstOrNull;
          final raw = barcode?.rawValue;
          if (raw != null) { _scanned = true; _bloc.add(ScanQrCodeEvent(raw)); }
        },
      ),
      Positioned(top: 0, left: 0, right: 0, child: Container(padding: const EdgeInsets.all(16), color: Colors.black54,
        child: const Text('Point camera at device QR code', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 15)))),
      Center(child: Container(width: 220, height: 220, decoration: BoxDecoration(border: Border.all(color: AppTheme.primaryColor, width: 2), borderRadius: BorderRadius.circular(16)))),
    ]);
  }
}
