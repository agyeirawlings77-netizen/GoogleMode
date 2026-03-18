enum LockType { pin, pattern, biometric, none }
class AppLockConfig {
  final LockType lockType;
  final String? hashedPin;
  final bool lockOnBackground;
  final int lockDelaySeconds;
  final bool biometricEnabled;
  final List<String> lockedApps;
  const AppLockConfig({this.lockType = LockType.none, this.hashedPin, this.lockOnBackground = true, this.lockDelaySeconds = 5, this.biometricEnabled = false, this.lockedApps = const []});
  AppLockConfig copyWith({LockType? lockType, String? hashedPin, bool? lockOnBackground, int? lockDelaySeconds, bool? biometricEnabled, List<String>? lockedApps}) =>
    AppLockConfig(lockType: lockType ?? this.lockType, hashedPin: hashedPin ?? this.hashedPin, lockOnBackground: lockOnBackground ?? this.lockOnBackground, lockDelaySeconds: lockDelaySeconds ?? this.lockDelaySeconds, biometricEnabled: biometricEnabled ?? this.biometricEnabled, lockedApps: lockedApps ?? this.lockedApps);
  factory AppLockConfig.fromJson(Map<String, dynamic> j) => AppLockConfig(lockType: LockType.values.firstWhere((t) => t.name == j['lockType'], orElse: () => LockType.none), hashedPin: j['hashedPin'], lockOnBackground: j['lockOnBackground'] ?? true, lockDelaySeconds: j['lockDelaySeconds'] ?? 5, biometricEnabled: j['biometricEnabled'] ?? false, lockedApps: List<String>.from(j['lockedApps'] ?? []));
  Map<String, dynamic> toJson() => {'lockType': lockType.name, 'hashedPin': hashedPin, 'lockOnBackground': lockOnBackground, 'lockDelaySeconds': lockDelaySeconds, 'biometricEnabled': biometricEnabled, 'lockedApps': lockedApps};
}
