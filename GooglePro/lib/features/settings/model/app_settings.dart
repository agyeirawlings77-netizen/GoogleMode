class AppSettings {
  final String language;
  final bool notificationsEnabled;
  final bool soundEnabled;
  final bool vibrationEnabled;
  final bool autoConnectEnabled;
  final bool backgroundSyncEnabled;
  final bool analyticsEnabled;
  final bool crashReportingEnabled;
  final int connectionTimeoutSeconds;
  final int defaultFps;
  final int defaultBitrateKbps;
  final bool showConnectionStats;
  final bool keepScreenOn;
  final bool autoUpdateEnabled;

  const AppSettings({this.language = 'en', this.notificationsEnabled = true, this.soundEnabled = true, this.vibrationEnabled = true, this.autoConnectEnabled = true, this.backgroundSyncEnabled = true, this.analyticsEnabled = true, this.crashReportingEnabled = true, this.connectionTimeoutSeconds = 30, this.defaultFps = 15, this.defaultBitrateKbps = 2000, this.showConnectionStats = false, this.keepScreenOn = true, this.autoUpdateEnabled = true});

  AppSettings copyWith({String? language, bool? notificationsEnabled, bool? soundEnabled, bool? vibrationEnabled, bool? autoConnectEnabled, bool? backgroundSyncEnabled, bool? analyticsEnabled, bool? crashReportingEnabled, int? connectionTimeoutSeconds, int? defaultFps, int? defaultBitrateKbps, bool? showConnectionStats, bool? keepScreenOn, bool? autoUpdateEnabled}) =>
    AppSettings(language: language ?? this.language, notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled, soundEnabled: soundEnabled ?? this.soundEnabled, vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled, autoConnectEnabled: autoConnectEnabled ?? this.autoConnectEnabled, backgroundSyncEnabled: backgroundSyncEnabled ?? this.backgroundSyncEnabled, analyticsEnabled: analyticsEnabled ?? this.analyticsEnabled, crashReportingEnabled: crashReportingEnabled ?? this.crashReportingEnabled, connectionTimeoutSeconds: connectionTimeoutSeconds ?? this.connectionTimeoutSeconds, defaultFps: defaultFps ?? this.defaultFps, defaultBitrateKbps: defaultBitrateKbps ?? this.defaultBitrateKbps, showConnectionStats: showConnectionStats ?? this.showConnectionStats, keepScreenOn: keepScreenOn ?? this.keepScreenOn, autoUpdateEnabled: autoUpdateEnabled ?? this.autoUpdateEnabled);

  factory AppSettings.fromJson(Map<String, dynamic> j) => AppSettings(language: j['language'] ?? 'en', notificationsEnabled: j['notificationsEnabled'] ?? true, soundEnabled: j['soundEnabled'] ?? true, vibrationEnabled: j['vibrationEnabled'] ?? true, autoConnectEnabled: j['autoConnectEnabled'] ?? true, backgroundSyncEnabled: j['backgroundSyncEnabled'] ?? true, analyticsEnabled: j['analyticsEnabled'] ?? true, crashReportingEnabled: j['crashReportingEnabled'] ?? true, connectionTimeoutSeconds: j['connectionTimeoutSeconds'] ?? 30, defaultFps: j['defaultFps'] ?? 15, defaultBitrateKbps: j['defaultBitrateKbps'] ?? 2000, showConnectionStats: j['showConnectionStats'] ?? false, keepScreenOn: j['keepScreenOn'] ?? true, autoUpdateEnabled: j['autoUpdateEnabled'] ?? true);

  Map<String, dynamic> toJson() => {'language': language, 'notificationsEnabled': notificationsEnabled, 'soundEnabled': soundEnabled, 'vibrationEnabled': vibrationEnabled, 'autoConnectEnabled': autoConnectEnabled, 'backgroundSyncEnabled': backgroundSyncEnabled, 'analyticsEnabled': analyticsEnabled, 'crashReportingEnabled': crashReportingEnabled, 'connectionTimeoutSeconds': connectionTimeoutSeconds, 'defaultFps': defaultFps, 'defaultBitrateKbps': defaultBitrateKbps, 'showConnectionStats': showConnectionStats, 'keepScreenOn': keepScreenOn, 'autoUpdateEnabled': autoUpdateEnabled};
}
