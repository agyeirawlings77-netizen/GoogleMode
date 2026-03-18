import 'package:injectable/injectable.dart';
import '../service/parental_control_service.dart';
import '../model/parental_profile.dart';
import '../model/app_usage_rule.dart';
import '../model/screen_time_model.dart';
import 'parental_repository.dart';
@LazySingleton(as: ParentalRepository)
class ParentalRepositoryImpl implements ParentalRepository {
  final ParentalControlService _svc;
  ParentalRepositoryImpl(this._svc);
  @override Future<void> saveProfile(ParentalProfile p) => _svc.saveProfile(p);
  @override Future<ParentalProfile?> loadProfile(String uid, String did) => _svc.loadProfile(uid, did);
  @override Future<void> saveRule(String uid, AppUsageRule r) => _svc.saveRule(uid, r);
  @override Future<void> deleteRule(String uid, String rid) => _svc.deleteRule(uid, rid);
  @override Future<List<AppUsageRule>> loadRules(String uid) => _svc.loadRules(uid);
  @override Future<ScreenTimeModel?> getTodayScreenTime(String did) => _svc.getTodayScreenTime(did);
  @override Future<void> lockDevice(String did) => _svc.lockDevice(did);
}
