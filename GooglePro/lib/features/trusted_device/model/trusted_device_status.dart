enum TrustedDeviceStatus { online, offline, connecting, unknown }
extension TrustedDeviceStatusExt on TrustedDeviceStatus {
  bool get isOnline => this == TrustedDeviceStatus.online;
  String get label { switch (this) { case TrustedDeviceStatus.online: return 'Online'; case TrustedDeviceStatus.offline: return 'Offline'; case TrustedDeviceStatus.connecting: return 'Connecting...'; default: return 'Unknown'; } }
}
