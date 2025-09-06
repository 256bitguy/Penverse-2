// lib/features/books/ui/book_view_model.dart
import 'package:Penverse/core/store/app_state.dart';
import 'package:redux/redux.dart';
import '../redux/book_state.dart';
import '../redux/book_actions.dart';
import '../../chapter/redux/chapter_actions.dart';

class BookViewModel {
  final bool isLoading;
  final List<Book> books;
  final String? error;

  // Actions
  final Function() loadBooks;
  final Function(String bookId) loadChaptersByBook;

  BookViewModel(
      {required this.isLoading,
      required this.books,
      this.error,
      required this.loadBooks,
      required this.loadChaptersByBook});

  /// Connects Redux store state to ViewModel
  static BookViewModel fromStore(Store<AppState> store) {
    return BookViewModel(
        isLoading: store.state.bookState.isLoading,
        books: store.state.bookState.books ?? [],
        error: store.state.bookState.error,
        loadBooks: () {
          store.dispatch(LoadBooksAction());
        },
        loadChaptersByBook: (bookId) {
          store.dispatch(LoadChaptersByBookAction(bookId));
        });
  }
}
