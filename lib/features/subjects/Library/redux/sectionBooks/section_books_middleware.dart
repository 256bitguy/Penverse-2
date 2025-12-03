import 'package:penverse/features/subjects/Library/redux/sectionBooks/section_book_model.dart';
import 'package:penverse/features/subjects/Library/redux/sectionBooks/section_books_services.dart';
import 'package:redux/redux.dart';
import 'package:penverse/core/store/app_state.dart';
import 'package:penverse/features/subjects/Library/redux/sectionBooks/section_books_actions.dart';

List<Middleware<AppState>> createSectionBooksMiddleware(
    SectionBooksService service) {
  return [
    TypedMiddleware<AppState, LoadBooksBySectionRequestAction>(
        _loadBooksBySection(service)),
  ];
}

Middleware<AppState> _loadBooksBySection(SectionBooksService service) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadBooksBySectionRequestAction) {
      next(action); // Always forward action

      try {
        // print("exactly\n\n\n\n\n\n\n");
        final response = await service.getBooksInSection(
          sectionId: action.sectionId,
        );
  //  print("done printing \n\n\n\n\n\n\n");
        final books = response["books"] as List;

        // Dispatch success action
        store.dispatch(
          LoadBooksBySectionSuccessAction(
            sectionId: action.sectionId,
            books: books.cast<SectionBook>(),
          ),
        );
      } catch (e) {
        // Dispatch failure action
        store.dispatch(
          LoadBooksBySectionFailureAction(
            sectionId: action.sectionId,
            error: e.toString(),
          ),
        );
      }
    }
  };
}
