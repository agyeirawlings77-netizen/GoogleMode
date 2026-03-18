class TrustedDeviceUiModel {
  final String deviceId;
  final String deviceName;
  final bool autoConnect;
  final DateTime pairedAt;
  final bool isCurrentlyOnline;
  const TrustedDeviceUiModel({required this.deviceId, required this.deviceName, required this.autoConnect, required this.pairedAt, this.isCurrentlyOnline = false});
}
