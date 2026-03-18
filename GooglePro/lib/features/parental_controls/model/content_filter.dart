enum ContentFilterLevel { off, low, medium, high, strict }
enum ContentCategory { adult, violence, gambling, drugs, socialMedia, gaming, streaming }
class ContentFilter {
  final ContentFilterLevel level;
  final Set<ContentCategory> blockedCategories;
  final List<String> blockedDomains;
  const ContentFilter({this.level = ContentFilterLevel.medium, this.blockedCategories = const {}, this.blockedDomains = const []});
  factory ContentFilter.fromJson(Map<String, dynamic> j) => ContentFilter(level: ContentFilterLevel.values.firstWhere((l) => l.name == j['level'], orElse: () => ContentFilterLevel.medium), blockedCategories: Set<ContentCategory>.from((j['blockedCategories'] as List? ?? []).map((c) => ContentCategory.values.firstWhere((e) => e.name == c, orElse: () => ContentCategory.adult))), blockedDomains: List<String>.from(j['blockedDomains'] ?? []));
  Map<String, dynamic> toJson() => {'level': level.name, 'blockedCategories': blockedCategories.map((c) => c.name).toList(), 'blockedDomains': blockedDomains};
}
