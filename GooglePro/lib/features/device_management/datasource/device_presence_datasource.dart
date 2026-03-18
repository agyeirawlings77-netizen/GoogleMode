import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import '../../../core/constants/app_constants.dart';
@singleton
class DevicePresenceDatasource {
  Future<void> setOnline(String uid, String deviceId) async {
    final ref = FirebaseDatabase.instance.ref('${AppConstants.presencePath}/$uid/$deviceId');
    await ref.update({'online': true, 'lastSeen': ServerValue.timestamp});
    await ref.onDisconnect().update({'online': false, 'lastSeen': ServerValue.timestamp});
  }
  Future<void> setOffline(String uid, String deviceId) async =>
    FirebaseDatabase.instance.ref('${AppConstants.presencePath}/$uid/$deviceId').update({'online': false, 'lastSeen': ServerValue.timestamp});
  Stream<bool> watchOnline(String uid, String deviceId) =>
    FirebaseDatabase.instance.ref('${AppConstants.presencePath}/$uid/$deviceId/online').onValue.map((e) => e.snapshot.value as bool? ?? false);
}
