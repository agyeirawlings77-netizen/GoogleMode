import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/profile_model.dart';
import '../state/profile_state.dart';
import '../state/profile_event.dart';
import '../../../core/utils/app_logger.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileInitial()) {
    on<LoadProfileEvent>(_onLoad);
    on<UpdateProfileEvent>(_onUpdate);
    on<UploadProfilePhotoEvent>(_onUploadPhoto);
  }

  void _onLoad(LoadProfileEvent e, Emitter<ProfileState> emit) {
    emit(const ProfileLoading());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) { emit(const ProfileError('Not logged in')); return; }
      emit(ProfileLoaded(ProfileModel(uid: user.uid, email: user.email ?? '', displayName: user.displayName, photoUrl: user.photoURL, phone: user.phoneNumber)));
    } catch (err) { emit(ProfileError(err.toString())); }
  }

  Future<void> _onUpdate(UpdateProfileEvent e, Emitter<ProfileState> emit) async {
    if (state is! ProfileLoaded) return;
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (e.displayName != null) await user?.updateDisplayName(e.displayName);
      emit(const ProfileSaved());
      add(const LoadProfileEvent());
    } catch (err) { emit(ProfileError(err.toString())); }
  }

  Future<void> _onUploadPhoto(UploadProfilePhotoEvent e, Emitter<ProfileState> emit) async {
    AppLogger.info('Profile photo upload (${e.imageData.length} bytes)');
  }
}
