class ProfileModel {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final String? phone;
  final String? bio;
  const ProfileModel({required this.uid, required this.email, this.displayName, this.photoUrl, this.phone, this.bio});
  ProfileModel copyWith({String? displayName, String? photoUrl, String? phone, String? bio}) =>
    ProfileModel(uid: uid, email: email, displayName: displayName ?? this.displayName, photoUrl: photoUrl ?? this.photoUrl, phone: phone ?? this.phone, bio: bio ?? this.bio);
}
