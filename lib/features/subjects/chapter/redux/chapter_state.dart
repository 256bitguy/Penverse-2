// lib/features/chapter/data/chapter_state.dart
class Chapter {
  final String id;
  final String title;
  final String description;
  final String bookId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Chapter({
    required this.id,
    required this.title,
    this.description = "",
    required this.bookId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json['_id'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        bookId: json['bookId'] ?? '',
        createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
        updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'description': description,
        'bookId': bookId,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}

class ChapterState {
  final bool isLoading;
  final List<Chapter> chapters;
  final String? error;

  ChapterState({
    this.isLoading = false,
    this.chapters = const [],
    this.error,
  });

  ChapterState copyWith({
    bool? isLoading,
    List<Chapter>? chapters,
    String? error,
  }) =>
      ChapterState(
        isLoading: isLoading ?? this.isLoading,
        chapters: chapters ?? this.chapters,
        error: error ?? this.error,
      );

  factory ChapterState.initial() => ChapterState();

  factory ChapterState.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ChapterState.initial();
    return ChapterState(
      isLoading: json['isLoading'] ?? false,
      error: json['error'],
      chapters: (json['chapters'] as List<dynamic>? ?? [])
          .map((e) => Chapter.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'isLoading': isLoading,
        'error': error,
        'chapters': chapters.map((e) => e.toJson()).toList(),
      };
}
