class SecuritySettings {
  final bool twoFactorEnabled;
  final bool unknownDeviceAlerts;
  final bool loginAlerts;
  final bool locationAlerts;
  final bool encryptionEnabled;
  final bool screenshotBlocked;
  final int sessionTimeoutMinutes;
  final DateTime? lastSecurityScan;

  const SecuritySettings({this.twoFactorEnabled = false, this.unknownDeviceAlerts = true, this.loginAlerts = true, this.locationAlerts = true, this.encryptionEnabled = true, this.screenshotBlocked = false, this.sessionTimeoutMinutes = 30, this.lastSecurityScan});

  SecuritySettings copyWith({bool? twoFactorEnabled, bool? unknownDeviceAlerts, bool? loginAlerts, bool? locationAlerts, bool? encryptionEnabled, bool? screenshotBlocked, int? sessionTimeoutMinutes}) =>
    SecuritySettings(twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled, unknownDeviceAlerts: unknownDeviceAlerts ?? this.unknownDeviceAlerts, loginAlerts: loginAlerts ?? this.loginAlerts, locationAlerts: locationAlerts ?? this.locationAlerts, encryptionEnabled: encryptionEnabled ?? this.encryptionEnabled, screenshotBlocked: screenshotBlocked ?? this.screenshotBlocked, sessionTimeoutMinutes: sessionTimeoutMinutes ?? this.sessionTimeoutMinutes, lastSecurityScan: lastSecurityScan);

  factory SecuritySettings.fromJson(Map<String, dynamic> j) => SecuritySettings(twoFactorEnabled: j['twoFactorEnabled'] ?? false, unknownDeviceAlerts: j['unknownDeviceAlerts'] ?? true, loginAlerts: j['loginAlerts'] ?? true, locationAlerts: j['locationAlerts'] ?? true, encryptionEnabled: j['encryptionEnabled'] ?? true, screenshotBlocked: j['screenshotBlocked'] ?? false, sessionTimeoutMinutes: j['sessionTimeoutMinutes'] ?? 30);
  Map<String, dynamic> toJson() => {'twoFactorEnabled': twoFactorEnabled, 'unknownDeviceAlerts': unknownDeviceAlerts, 'loginAlerts': loginAlerts, 'locationAlerts': locationAlerts, 'encryptionEnabled': encryptionEnabled, 'screenshotBlocked': screenshotBlocked, 'sessionTimeoutMinutes': sessionTimeoutMinutes};
}
