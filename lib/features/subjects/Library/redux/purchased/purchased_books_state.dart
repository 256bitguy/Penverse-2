import 'package:penverse/core/models/book_model.dart';

class PurchasedBooksState {
  final List<Book> results;
  final int totalResults;
  final int totalPages;
  final int currentPage;
  final bool isLoading;
  final String? error;

  PurchasedBooksState({
    required this.results,
    required this.totalResults,
    required this.totalPages,
    required this.currentPage,
    required this.isLoading,
    this.error,
  });

  factory PurchasedBooksState.initial() => PurchasedBooksState(
        results: [],
        totalResults: 0,
        totalPages: 0,
        currentPage: 1,
        isLoading: false,
        error: null,
      );

  PurchasedBooksState copyWith({
    List<Book>? results,
    int? totalResults,
    int? totalPages,
    int? currentPage,
    bool? isLoading,
    String? error,
  }) {
    return PurchasedBooksState(
      results: results ?? this.results,
      totalResults: totalResults ?? this.totalResults,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  // ------------------------------
  //        FROM JSON
  // ------------------------------
  factory PurchasedBooksState.fromJson(Map<String, dynamic> json) {
    return PurchasedBooksState(
      results: json['results'] != null
          ? List<Book>.from(json['results'].map((x) => Book.fromJson(x)))
          : [],
      totalResults: json['totalResults'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      currentPage: json['currentPage'] ?? 1,
      isLoading: json['isLoading'] ?? false,
      error: json['error'],
    );
  }

  // ------------------------------
  //        TO JSON
  // ------------------------------
  Map<String, dynamic> toJson() {
    return {
      'results': results.map((x) => x.toJson()).toList(),
      'totalResults': totalResults,
      'totalPages': totalPages,
      'currentPage': currentPage,
      'isLoading': isLoading,
      'error': error,
    };
  }
}
