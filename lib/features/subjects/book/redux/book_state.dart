// lib/features/books/redux/book_state.dart

import 'package:penverse/core/models/book_model.dart';

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
