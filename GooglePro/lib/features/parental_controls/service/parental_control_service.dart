import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import '../model/parental_profile.dart';
import '../model/app_usage_rule.dart';
import '../model/screen_time_model.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class ParentalControlService {
  final _db = FirebaseDatabase.instance;

  Future<void> saveProfile(ParentalProfile profile) async {
    await _db.ref('parental/${profile.parentUserId}/profiles/${profile.profileId}').set(profile.toJson());
    AppLogger.info('Parental profile saved: ${profile.childName}');
  }

  Future<ParentalProfile?> loadProfile(String parentUid, String deviceId) async {
    try {
      final snap = await _db.ref('parental/$parentUid/profiles').orderByChild('childDeviceId').equalTo(deviceId).limitToFirst(1).get();
      if (!snap.exists) return null;
      final data = (snap.value as Map<dynamic, dynamic>).values.first;
      return ParentalProfile.fromJson(Map<String, dynamic>.from(data as Map));
    } catch (e) { AppLogger.error('Load parental profile failed', e); return null; }
  }

  Future<void> saveRule(String parentUid, AppUsageRule rule) async {
    await _db.ref('parental/$parentUid/rules/${rule.ruleId}').set(rule.toJson());
  }

  Future<void> deleteRule(String parentUid, String ruleId) async {
    await _db.ref('parental/$parentUid/rules/$ruleId').remove();
  }

  Future<List<AppUsageRule>> loadRules(String parentUid) async {
    try {
      final snap = await _db.ref('parental/$parentUid/rules').get();
      if (!snap.exists) return [];
      final data = snap.value as Map<dynamic, dynamic>;
      return data.values.map((v) => AppUsageRule.fromJson(Map<String, dynamic>.from(v as Map))).toList();
    } catch (e) { return []; }
  }

  Future<ScreenTimeModel?> getTodayScreenTime(String deviceId) async {
    try {
      final today = DateTime.now().toIso8601String().substring(0, 10);
      final snap = await _db.ref('screen_time/$deviceId/$today').get();
      if (!snap.exists) return ScreenTimeModel(deviceId: deviceId, date: DateTime.now(), totalMinutes: 0, appUsageMinutes: {});
      return ScreenTimeModel.fromJson(Map<String, dynamic>.from(snap.value as Map));
    } catch (e) { return null; }
  }

  Future<void> lockDevice(String targetDeviceId) async {
    await _db.ref('device_commands/$targetDeviceId').push().set({'command': 'lock', 'timestamp': ServerValue.timestamp});
    AppLogger.info('Lock command sent to $targetDeviceId');
  }

  Future<void> unlockDevice(String targetDeviceId) async {
    await _db.ref('device_commands/$targetDeviceId').push().set({'command': 'unlock', 'timestamp': ServerValue.timestamp});
  }

  Stream<ScreenTimeModel?> watchScreenTime(String deviceId) {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    return _db.ref('screen_time/$deviceId/$today').onValue.map((e) {
      if (!e.snapshot.exists) return null;
      return ScreenTimeModel.fromJson(Map<String, dynamic>.from(e.snapshot.value as Map));
    });
  }
}
