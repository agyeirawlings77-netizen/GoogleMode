import 'package:equatable/equatable.dart';
import '../model/parental_profile.dart';
import '../model/app_usage_rule.dart';

abstract class ParentalEvent extends Equatable {
  const ParentalEvent();
  @override List<Object?> get props => [];
}
class LoadParentalDataEvent extends ParentalEvent {
  final String deviceId;
  const LoadParentalDataEvent(this.deviceId);
  @override List<Object?> get props => [deviceId];
}
class SaveProfileEvent extends ParentalEvent {
  final ParentalProfile profile;
  const SaveProfileEvent(this.profile);
  @override List<Object?> get props => [profile];
}
class AddRuleEvent extends ParentalEvent {
  final AppUsageRule rule;
  const AddRuleEvent(this.rule);
  @override List<Object?> get props => [rule];
}
class ToggleRuleEvent extends ParentalEvent {
  final String ruleId;
  final bool isBlocked;
  const ToggleRuleEvent(this.ruleId, this.isBlocked);
  @override List<Object?> get props => [ruleId, isBlocked];
}
class RemoveRuleEvent extends ParentalEvent {
  final String ruleId;
  const RemoveRuleEvent(this.ruleId);
  @override List<Object?> get props => [ruleId];
}
class UpdateScreenLimitEvent extends ParentalEvent {
  final int minutes;
  const UpdateScreenLimitEvent(this.minutes);
  @override List<Object?> get props => [minutes];
}
class LockDeviceEvent extends ParentalEvent {
  final String targetDeviceId;
  const LockDeviceEvent(this.targetDeviceId);
  @override List<Object?> get props => [targetDeviceId];
}
