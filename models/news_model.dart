class News {
  final String title;
  final String description;
  final String content;
  final String imageURL;
  final String category;
  final DateTime publishedAt;
  final String source;

  News({
    required this.title,
    required this.description,
    required this.content,
    required this.imageURL,
    required this.category,
    required this.publishedAt,
    required this.source,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    // createdAt is from mongoose timestamps
    final createdAtStr = json['createdAt'] ?? json['createdAT'] ?? json['publishedAt'];
    DateTime published;
    if (createdAtStr == null) {
      published = DateTime.now();
    } else {
      try {
        published = DateTime.parse(createdAtStr.toString());
      } catch (_) {
        published = DateTime.now();
      }
    }

    return News(
      title: (json['title'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      content: (json['content'] ?? '') as String,
      imageURL: (json['imageURL'] ?? '') as String,
      category: (json['category'] ?? '') as String,
      source: (json['source'] ?? '') as String,
      publishedAt: published,
    );
  }
}
