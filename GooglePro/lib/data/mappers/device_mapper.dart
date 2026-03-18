import '../models/device_model.dart';
import '../../domain/entities/device_entity.dart';

class DeviceMapper {
  static DeviceModel fromJson(Map<String, dynamic> j, String id) => DeviceModel.fromJson({...j, 'deviceId': id});
  static Map<String, dynamic> toFirestore(DeviceEntity e) => DeviceModel(deviceId: e.deviceId, deviceName: e.deviceName, type: e.type, ownerUserId: e.ownerUserId, status: e.status, fcmToken: e.fcmToken, osVersion: e.osVersion, appVersion: e.appVersion, batteryLevel: e.batteryLevel).toJson();
}
