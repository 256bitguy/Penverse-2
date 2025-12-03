 
import 'package:penverse/core/store/app_state.dart';
 
import 'package:penverse/features/subjects/Library/redux/sectionBooks/section_book_model.dart';
import 'package:penverse/features/subjects/Library/redux/sectionBooks/section_books_actions.dart';
import 'package:redux/redux.dart';

class SectionBooksViewModel {
  final List<SectionBook> books;
  final bool isLoading;
  final String? error;

  final void Function(String sectionId) loadBooks;

  SectionBooksViewModel({
    required this.books,
    required this.isLoading,
    required this.error,
    required this.loadBooks,
  });

  /// Factory to create ViewModel from Redux store
  factory SectionBooksViewModel.fromStore(Store<AppState> store, String sectionId) {
    final books = store.state.sectionBooksState.booksBySection[sectionId] ?? [];
    final isLoading = store.state.sectionBooksState.isLoadingBySection[sectionId] ?? false;
    final error = store.state.sectionBooksState.errorBySection[sectionId];

    return SectionBooksViewModel(
      books: books,
      isLoading: isLoading,
      error: error,
      loadBooks: (id) {
        store.dispatch(LoadBooksBySectionRequestAction(id));
      },
    );
  }
}
