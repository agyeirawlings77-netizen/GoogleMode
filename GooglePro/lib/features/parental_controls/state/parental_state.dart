import 'package:equatable/equatable.dart';
import '../model/parental_profile.dart';
import '../model/screen_time_model.dart';
import '../model/app_usage_rule.dart';

abstract class ParentalState extends Equatable {
  const ParentalState();
  @override List<Object?> get props => [];
}
class ParentalInitial extends ParentalState { const ParentalInitial(); }
class ParentalLoading extends ParentalState { const ParentalLoading(); }
class ParentalLoaded extends ParentalState {
  final ParentalProfile? profile;
  final ScreenTimeModel? todayScreenTime;
  final List<AppUsageRule> rules;
  const ParentalLoaded({this.profile, this.todayScreenTime, this.rules = const []});
  @override List<Object?> get props => [profile, todayScreenTime, rules];
  ParentalLoaded copyWith({ParentalProfile? profile, ScreenTimeModel? todayScreenTime, List<AppUsageRule>? rules}) =>
    ParentalLoaded(profile: profile ?? this.profile, todayScreenTime: todayScreenTime ?? this.todayScreenTime, rules: rules ?? this.rules);
}
class ParentalError extends ParentalState {
  final String message;
  const ParentalError(this.message);
  @override List<Object?> get props => [message];
}
class ParentalRuleSaved extends ParentalState { const ParentalRuleSaved(); }
class ParentalProfileSaved extends ParentalState { const ParentalProfileSaved(); }
