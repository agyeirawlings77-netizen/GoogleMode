class ParentalProfile {
  final String profileId;
  final String childName;
  final String childDeviceId;
  final String parentUserId;
  final int dailyScreenLimitMinutes;
  final bool contentFilterEnabled;
  final bool locationSharingEnabled;
  final bool webFilterEnabled;
  final List<String> blockedApps;
  final List<String> blockedWebsites;
  final bool isActive;

  const ParentalProfile({required this.profileId, required this.childName, required this.childDeviceId, required this.parentUserId, this.dailyScreenLimitMinutes = 120, this.contentFilterEnabled = true, this.locationSharingEnabled = true, this.webFilterEnabled = true, this.blockedApps = const [], this.blockedWebsites = const [], this.isActive = true});

  ParentalProfile copyWith({int? dailyScreenLimitMinutes, bool? contentFilterEnabled, bool? locationSharingEnabled, bool? webFilterEnabled, List<String>? blockedApps, List<String>? blockedWebsites, bool? isActive}) =>
    ParentalProfile(profileId: profileId, childName: childName, childDeviceId: childDeviceId, parentUserId: parentUserId, dailyScreenLimitMinutes: dailyScreenLimitMinutes ?? this.dailyScreenLimitMinutes, contentFilterEnabled: contentFilterEnabled ?? this.contentFilterEnabled, locationSharingEnabled: locationSharingEnabled ?? this.locationSharingEnabled, webFilterEnabled: webFilterEnabled ?? this.webFilterEnabled, blockedApps: blockedApps ?? this.blockedApps, blockedWebsites: blockedWebsites ?? this.blockedWebsites, isActive: isActive ?? this.isActive);

  factory ParentalProfile.fromJson(Map<String, dynamic> j) => ParentalProfile(profileId: j['profileId'] ?? '', childName: j['childName'] ?? '', childDeviceId: j['childDeviceId'] ?? '', parentUserId: j['parentUserId'] ?? '', dailyScreenLimitMinutes: j['dailyScreenLimitMinutes'] ?? 120, contentFilterEnabled: j['contentFilterEnabled'] ?? true, locationSharingEnabled: j['locationSharingEnabled'] ?? true, webFilterEnabled: j['webFilterEnabled'] ?? true, blockedApps: List<String>.from(j['blockedApps'] ?? []), blockedWebsites: List<String>.from(j['blockedWebsites'] ?? []), isActive: j['isActive'] ?? true);
  Map<String, dynamic> toJson() => {'profileId': profileId, 'childName': childName, 'childDeviceId': childDeviceId, 'parentUserId': parentUserId, 'dailyScreenLimitMinutes': dailyScreenLimitMinutes, 'contentFilterEnabled': contentFilterEnabled, 'locationSharingEnabled': locationSharingEnabled, 'webFilterEnabled': webFilterEnabled, 'blockedApps': blockedApps, 'blockedWebsites': blockedWebsites, 'isActive': isActive};
}
