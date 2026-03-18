import 'device_model.dart';

class PairedDeviceModel {
  final DeviceModel device;
  final String pairingCode;
  final DateTime pairedAt;
  final String? sessionId;
  const PairedDeviceModel({required this.device, required this.pairingCode, required this.pairedAt, this.sessionId});
}
