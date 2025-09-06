// lib/features/subjects/chapter/redux/chapter_state.dart

/// ===============================
/// CHAPTER DATA MODEL
/// ===============================
class Chapter {
  final String id;
  final String title;
  final String description;
  final String bookId;
  final String? bookTitle;
  final String? bookAuthor;
  final DateTime createdAt;
  final DateTime updatedAt;

  Chapter({
    required this.id,
    required this.title,
    this.description = "",
    required this.bookId,
    this.bookTitle,
    this.bookAuthor,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create Chapter from JSON (API -> Flutter)
  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      bookId: json['bookId'] is Map ? json['bookId']['_id'] ?? '' : json['bookId'] ?? '',
      bookTitle: json['bookId'] is Map ? json['bookId']['title'] ?? '' : null,
      bookAuthor: json['bookId'] is Map ? json['bookId']['author'] ?? '' : null,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  /// Convert Chapter to JSON (Flutter -> API)
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'bookId': bookId,
      'bookTitle': bookTitle,
      'bookAuthor': bookAuthor,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

/// ===============================
/// CHAPTER REDUX STATE
/// ===============================
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
  }) {
    return ChapterState(
      isLoading: isLoading ?? this.isLoading,
      chapters: chapters ?? this.chapters,
      error: error ?? this.error,
    );
  }

  factory ChapterState.initial() => ChapterState();

  factory ChapterState.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ChapterState.initial();

    return ChapterState(
      isLoading: json['isLoading'] ?? false,
      error: json['error'],
      chapters: (json['chapters'] as List<dynamic>? ?? [])
          .map((item) => Chapter.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'error': error,
      'chapters': chapters.map((chapter) => chapter.toJson()).toList(),
    };
  }
}
