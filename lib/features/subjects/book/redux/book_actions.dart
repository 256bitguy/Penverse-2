// lib/features/books/redux/book_actions.dart
import 'book_state.dart';

/// ===============================
/// BOOK ACTIONS
/// ===============================

/// Action to start loading books
class LoadBooksAction {}

/// Action dispatched when books are successfully loaded
class LoadBooksSuccessAction {
  final List<Book> books;
  LoadBooksSuccessAction(this.books);
}

/// Action dispatched when there is an error loading books
class LoadBooksFailureAction {
  final String error;
  LoadBooksFailureAction(this.error);
}
class LoadBooksBySubjectAction {
  final String subjectId;
  LoadBooksBySubjectAction(this.subjectId);
}