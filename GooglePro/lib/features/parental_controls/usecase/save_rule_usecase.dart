import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../model/app_usage_rule.dart';
import '../repository/parental_repository.dart';
@injectable
class SaveRuleUsecase {
  final ParentalRepository _repo;
  SaveRuleUsecase(this._repo);
  Future<void> call(AppUsageRule rule) => _repo.saveRule(FirebaseAuth.instance.currentUser?.uid ?? '', rule);
}
