import '../model/trusted_device_model.dart';

class TrustedDeviceMapper {
  static Map<String, dynamic> toFirestore(TrustedDeviceModel d) => {'deviceId': d.deviceId, 'deviceName': d.deviceName, 'deviceType': d.deviceType, 'ownerUserId': d.ownerUserId, 'fcmToken': d.fcmToken, 'savedAt': d.savedAt.toIso8601String()};
  static TrustedDeviceModel fromFirestore(Map<String, dynamic> data) => TrustedDeviceModel.fromJson(data);
}
