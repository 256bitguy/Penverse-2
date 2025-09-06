// lib/features/books/redux/book_state.dart

/// ===============================
/// NESTED SUBJECT MODEL (for Book)
/// ===============================
class BookSubject {
  final String id;
  final String name;

  BookSubject({
    required this.id,
    required this.name,
  });

  factory BookSubject.fromJson(Map<String, dynamic> json) {
    return BookSubject(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

/// ===============================
/// BOOK DATA MODEL
/// ===============================
class Book {
  final String id;
  final BookSubject subject; // <-- Nested subject object
  final String title;
  final String description;
  final String coverImage;
  final int totalChapters;
  final String author;
  final int publishedYear;
  final DateTime createdAt;
  final DateTime updatedAt;

  Book({
    required this.id,
    required this.subject,
    required this.title,
    this.description = "",
    this.coverImage = "",
    this.totalChapters = 0,
    this.author = "Unknown",
    required this.publishedYear,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create Book from JSON
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['_id'] ?? '',
      subject: json['subjectId'] != null
          ? BookSubject.fromJson(Map<String, dynamic>.from(json['subjectId']))
          : BookSubject(id: '', name: ''),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      coverImage: json['coverImage'] ?? '',
      totalChapters: json['totalChapters'] ?? 0,
      author: json['author'] ?? 'Unknown',
      publishedYear: json['publishedYear'] ?? DateTime.now().year,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  /// Convert Book to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'subjectId': subject.toJson(), // <-- Nested object serialized
      'title': title,
      'description': description,
      'coverImage': coverImage,
      'totalChapters': totalChapters,
      'author': author,
      'publishedYear': publishedYear,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

/// ===============================
/// BOOK REDUX STATE
/// ===============================
class BookState {
  final bool isLoading;
  final List<Book> books;
  final String? error;

  BookState({
    this.isLoading = false,
    this.books = const [],
    this.error,
  });

  /// Copy state with modifications
  BookState copyWith({
    bool? isLoading,
    List<Book>? books,
    String? error,
  }) {
    return BookState(
      isLoading: isLoading ?? this.isLoading,
      books: books ?? this.books,
      error: error ?? this.error,
    );
  }

  /// Initial empty state
  factory BookState.initial() => BookState();

  /// Create state from JSON
  factory BookState.fromJson(Map<String, dynamic>? json) {
    if (json == null) return BookState.initial();

    return BookState(
      isLoading: json['isLoading'] ?? false,
      error: json['error'],
      books: (json['books'] as List<dynamic>? ?? [])
          .map((item) => Book.fromJson(item))
          .toList(),
    );
  }

  /// Convert state to JSON
  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'error': error,
      'books': books.map((book) => book.toJson()).toList(),
    };
  }
}
