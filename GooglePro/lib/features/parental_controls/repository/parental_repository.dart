import '../model/parental_profile.dart';
import '../model/app_usage_rule.dart';
import '../model/screen_time_model.dart';
abstract class ParentalRepository {
  Future<void> saveProfile(ParentalProfile profile);
  Future<ParentalProfile?> loadProfile(String parentUid, String deviceId);
  Future<void> saveRule(String parentUid, AppUsageRule rule);
  Future<void> deleteRule(String parentUid, String ruleId);
  Future<List<AppUsageRule>> loadRules(String parentUid);
  Future<ScreenTimeModel?> getTodayScreenTime(String deviceId);
  Future<void> lockDevice(String deviceId);
}
