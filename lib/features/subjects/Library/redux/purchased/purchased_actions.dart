import 'package:penverse/core/models/book_model.dart';

class PurchasedBooksAction {
  final int page;

  PurchasedBooksAction({
    this.page = 1,
  });
}

class PurchasedBooksSuccessAction {
  final List<Book> results;
  final int totalResults;
  final int totalPages;
  final int currentPage;

  PurchasedBooksSuccessAction({
    required this.results,
    required this.totalResults,
    required this.totalPages,
    required this.currentPage,
  });
}

class PurchasedBooksFailedAction {
  final String error;
  PurchasedBooksFailedAction(this.error);
}
