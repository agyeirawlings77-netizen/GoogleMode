import 'package:equatable/equatable.dart';
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override List<Object?> get props => [];
}
class LoadProfileEvent extends ProfileEvent { const LoadProfileEvent(); }
class UpdateProfileEvent extends ProfileEvent {
  final String? displayName;
  final String? phone;
  final String? bio;
  const UpdateProfileEvent({this.displayName, this.phone, this.bio});
  @override List<Object?> get props => [displayName, phone, bio];
}
class UploadProfilePhotoEvent extends ProfileEvent {
  final List<int> imageData;
  const UploadProfilePhotoEvent(this.imageData);
  @override List<Object?> get props => [imageData.length];
}
