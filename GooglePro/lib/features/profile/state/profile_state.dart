import 'package:equatable/equatable.dart';
import '../model/profile_model.dart';
abstract class ProfileState extends Equatable {
  const ProfileState();
  @override List<Object?> get props => [];
}
class ProfileInitial extends ProfileState { const ProfileInitial(); }
class ProfileLoading extends ProfileState { const ProfileLoading(); }
class ProfileLoaded extends ProfileState {
  final ProfileModel profile;
  const ProfileLoaded(this.profile);
  @override List<Object?> get props => [profile];
  ProfileLoaded copyWith({ProfileModel? profile}) => ProfileLoaded(profile ?? this.profile);
}
class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);
  @override List<Object?> get props => [message];
}
class ProfileSaved extends ProfileState { const ProfileSaved(); }
