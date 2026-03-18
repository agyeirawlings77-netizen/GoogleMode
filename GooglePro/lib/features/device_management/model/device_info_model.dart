class DeviceInfoModel {
  final String deviceId;
  final String manufacturer;
  final String model;
  final String osVersion;
  final String appVersion;
  final int totalRam;
  final int usedRam;
  final int totalStorage;
  final int usedStorage;
  final int batteryLevel;
  final bool isCharging;
  final double cpuUsage;
  final String? networkType;
  final String? ipAddress;
  const DeviceInfoModel({required this.deviceId, required this.manufacturer, required this.model, required this.osVersion, required this.appVersion, this.totalRam = 0, this.usedRam = 0, this.totalStorage = 0, this.usedStorage = 0, this.batteryLevel = 0, this.isCharging = false, this.cpuUsage = 0, this.networkType, this.ipAddress});
  factory DeviceInfoModel.fromJson(Map<String, dynamic> j) => DeviceInfoModel(deviceId: j['deviceId'] ?? '', manufacturer: j['manufacturer'] ?? '', model: j['model'] ?? '', osVersion: j['osVersion'] ?? '', appVersion: j['appVersion'] ?? '', totalRam: j['totalRam'] ?? 0, usedRam: j['usedRam'] ?? 0, totalStorage: j['totalStorage'] ?? 0, usedStorage: j['usedStorage'] ?? 0, batteryLevel: j['batteryLevel'] ?? 0, isCharging: j['isCharging'] ?? false, cpuUsage: (j['cpuUsage'] ?? 0).toDouble(), networkType: j['networkType'], ipAddress: j['ipAddress']);
  Map<String, dynamic> toJson() => {'deviceId': deviceId, 'manufacturer': manufacturer, 'model': model, 'osVersion': osVersion, 'appVersion': appVersion, 'totalRam': totalRam, 'usedRam': usedRam, 'totalStorage': totalStorage, 'usedStorage': usedStorage, 'batteryLevel': batteryLevel, 'isCharging': isCharging, 'cpuUsage': cpuUsage, 'networkType': networkType, 'ipAddress': ipAddress};
}
