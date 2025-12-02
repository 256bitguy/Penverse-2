import 'package:penverse/core/models/book_model.dart';

 
class SearchState {
  final bool isLoading;
  final List<Book> results;
  final int totalResults;
  final int currentPage;
  final int totalPages;
  final String error;

  SearchState({
    required this.isLoading,
    required this.results,
    required this.totalResults,
    required this.currentPage,
    required this.totalPages,
    required this.error,
  });

  /// -------------------------
  /// INITIAL STATE
  /// -------------------------
  factory SearchState.initial() {
    return SearchState(
      isLoading: false,
      results: const [],
      totalResults: 0,
      currentPage: 1,
      totalPages: 1,
      error: '',
    );
  }

  SearchState copyWith({
    bool? isLoading,
    List<Book>? results,
    int? totalResults,
    int? currentPage,
    int? totalPages,
    String? error,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      results: results ?? this.results,
      totalResults: totalResults ?? this.totalResults,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      error: error ?? this.error,
    );
  }

  /// -------------------------
  /// TO JSON
  /// -------------------------
  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'results': results,
      'totalResults': totalResults,
      'currentPage': currentPage,
      'totalPages': totalPages,
      'error': error,
    };
  }

  /// -------------------------
  /// FROM JSON
  /// -------------------------
  factory SearchState.fromJson(Map<String, dynamic> json) {
    return SearchState(
      isLoading: json['isLoading'] ?? false,
      results: (json['results'] as List<dynamic>? ?? [])
          .map((data) => Book.fromJson(Map<String, dynamic>.from(data)))
          .toList(),
      totalResults: json['totalResults'] ?? 0,
      currentPage: json['currentPage'] ?? 1,
      totalPages: json['totalPages'] ?? 1,
      error: json['error'] ?? '',
    );
  }
}
