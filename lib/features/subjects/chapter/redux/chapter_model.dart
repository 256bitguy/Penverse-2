class Chapter  {
  final String id;
  final String title;
  final String description;
  final String bookId;
  final String? bookTitle;
  final String? bookAuthor;
  final int ranking;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Chapter ({
    required this.id,
    required this.title,
    this.description = "",
    required this.bookId,
    this.bookTitle,
    this.bookAuthor,
    required this.ranking,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Chapter .fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      bookId: json['bookId'] is Map ? json['bookId']['_id'] ?? '' : json['bookId'] ?? '',
      bookTitle: json['bookId'] is Map ? json['bookId']['title'] ?? '' : null,
      bookAuthor: json['bookId'] is Map ? json['bookId']['author'] ?? '' : null,
      ranking: json['ranking'] ?? 0,
      imageUrl: json['imageUrl'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'bookId': bookId,
      'bookTitle': bookTitle,
      'bookAuthor': bookAuthor,
      'ranking': ranking,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
