import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../model/device_model.dart';

class DeviceMapper {
  static DeviceModel fromFirestore(Map<String, dynamic> data, String id) => DeviceModel.fromJson({...data, 'deviceId': id});
  static Map<String, dynamic> toFirestore(DeviceModel d) => d.toJson();
}
