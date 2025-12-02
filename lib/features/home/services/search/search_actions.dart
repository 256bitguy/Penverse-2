import 'package:penverse/core/models/book_model.dart';

class InitializeAuth {}

class SearchBooksAction {
  final String query;
  final int page;

  SearchBooksAction(this.query, {this.page = 1});
}

class SearchBooksSuccessAction {
  final List<Book> results;
  final int totalResults;
  final int totalPages;
  final int currentPage;

  SearchBooksSuccessAction({
    required this.results,
    required this.totalResults,
    required this.totalPages,
    required this.currentPage,
  });
}

class SearchBooksFailedAction {
  final String error;
  SearchBooksFailedAction(this.error);
}
