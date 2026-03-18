class DateFormatter {
  static String timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${dt.day}/${dt.month}/${dt.year}';
  }
  static String formatTime(DateTime dt) => '${dt.hour.toString().padLeft(2,'0')}:${dt.minute.toString().padLeft(2,'0')}';
  static String formatDate(DateTime dt) => '${dt.day}/${dt.month}/${dt.year}';
  static String formatDateTime(DateTime dt) => '${formatDate(dt)} ${formatTime(dt)}';
  static String formatDuration(Duration d) {
    if (d.inHours > 0) return '${d.inHours}h ${(d.inMinutes%60).toString().padLeft(2,'0')}m';
    if (d.inMinutes > 0) return '${d.inMinutes}m ${(d.inSeconds%60)}s';
    return '${d.inSeconds}s';
  }
}
