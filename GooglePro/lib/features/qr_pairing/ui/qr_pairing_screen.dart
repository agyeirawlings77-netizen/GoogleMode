import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../model/pairing_data.dart';
import '../service/qr_pairing_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class QrPairingScreen extends StatefulWidget {
  const QrPairingScreen({super.key});
  @override State<QrPairingScreen> createState() => _QrPairingScreenState();
}

class _QrPairingScreenState extends State<QrPairingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabs;
  late PairingData _myPairingData;
  bool _scanning = false;
  bool _paired = false;
  MobileScannerController? _scanCtrl;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
    _myPairingData = getIt<QrPairingService>().generatePairingData();
    _scanCtrl = MobileScannerController();
  }

  @override void dispose() { _tabs.dispose(); _scanCtrl?.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        title: const Text('Pair Device', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)),
        backgroundColor: AppTheme.darkSurface, elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop()),
        bottom: TabBar(controller: _tabs, indicatorColor: AppTheme.primaryColor, labelColor: AppTheme.primaryColor, unselectedLabelColor: AppTheme.darkSubtext, tabs: const [Tab(text: 'My QR Code'), Tab(text: 'Scan Code')]),
      ),
      body: TabBarView(controller: _tabs, children: [
        _buildMyQr(),
        _buildScanner(),
      ]),
    );
  }

  Widget _buildMyQr() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('Share this QR code', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 14)),
      const SizedBox(height: 8),
      const Text('Other device scans this to pair with you', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 12)),
      const SizedBox(height: 28),
      Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: QrImageView(data: _myPairingData.toQrString(), version: QrVersions.auto, size: 220, backgroundColor: Colors.white)).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
      const SizedBox(height: 20),
      Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: AppTheme.warningColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10), border: Border.all(color: AppTheme.warningColor.withOpacity(0.3))), child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.timer, color: AppTheme.warningColor, size: 14), SizedBox(width: 6), Text('Expires in 5 minutes', style: TextStyle(color: AppTheme.warningColor, fontSize: 12))])),
      const SizedBox(height: 16),
      TextButton.icon(onPressed: () => setState(() => _myPairingData = getIt<QrPairingService>().generatePairingData()), icon: const Icon(Icons.refresh, color: AppTheme.primaryColor, size: 18), label: const Text('Regenerate', style: TextStyle(color: AppTheme.primaryColor))),
    ]));
  }

  Widget _buildScanner() {
    if (_paired) return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.check_circle, color: AppTheme.successColor, size: 80).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
      const SizedBox(height: 20),
      const Text('Device Paired!', style: TextStyle(color: AppTheme.darkText, fontSize: 24, fontWeight: FontWeight.w700)),
      const SizedBox(height: 24),
      ElevatedButton(onPressed: () => context.pop(), style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), minimumSize: const Size(180, 52)), child: const Text('Done', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16))),
    ]));

    return Stack(children: [
      MobileScanner(controller: _scanCtrl!, onDetect: _onDetect),
      // Scanner overlay
      Center(child: Container(width: 240, height: 240, decoration: BoxDecoration(border: Border.all(color: AppTheme.primaryColor, width: 3), borderRadius: BorderRadius.circular(20)))),
      if (_scanning) const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor)),
      Positioned(bottom: 40, left: 0, right: 0, child: const Text('Point camera at QR code on the other device', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14))),
    ]);
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_scanning || _paired) return;
    final barcode = capture.barcodes.firstOrNull;
    if (barcode?.rawValue == null) return;
    setState(() => _scanning = true);
    try {
      final data = PairingData.fromQrString(barcode!.rawValue!);
      if (data == null) { setState(() => _scanning = false); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid QR code'), backgroundColor: AppTheme.errorColor)); return; }
      await getIt<QrPairingService>().completePairing(data);
      setState(() { _paired = true; _scanning = false; });
      _scanCtrl?.stop();
    } catch (e) {
      setState(() => _scanning = false);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()), backgroundColor: AppTheme.errorColor));
    }
  }
}
