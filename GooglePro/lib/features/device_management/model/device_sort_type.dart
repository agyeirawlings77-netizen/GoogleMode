enum DeviceSortType { name, lastSeen, online }
extension DeviceSortTypeExt on DeviceSortType {
  String get label { switch (this) { case DeviceSortType.name: return 'Name'; case DeviceSortType.lastSeen: return 'Last Seen'; case DeviceSortType.online: return 'Online First'; } }
}
