enum DeviceFilterType { all, online, offline, phone, tablet }
extension DeviceFilterTypeExt on DeviceFilterType {
  String get label { switch (this) { case DeviceFilterType.all: return 'All'; case DeviceFilterType.online: return 'Online'; case DeviceFilterType.offline: return 'Offline'; case DeviceFilterType.phone: return 'Phones'; case DeviceFilterType.tablet: return 'Tablets'; } }
}
