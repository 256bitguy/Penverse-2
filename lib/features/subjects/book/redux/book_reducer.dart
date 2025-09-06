// lib/features/books/redux/book_reducer.dart
import 'book_state.dart';
import 'book_actions.dart';

/// ===============================
/// BOOK REDUCER
/// ===============================
BookState bookReducer(BookState state, dynamic action) {
  if (action is LoadBooksAction || action is LoadBooksBySubjectAction) {
    return state.copyWith(isLoading: true, error: null);
  } else if (action is LoadBooksSuccessAction) {
    return state.copyWith(isLoading: false, books: action.books, error: null);
  } else if (action is LoadBooksFailureAction) {
    return state.copyWith(isLoading: false, error: action.error);
  }
  return state;
}