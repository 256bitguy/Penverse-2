import 'package:redux/redux.dart';
import 'search_actions.dart';
import 'search_services.dart';
import '../../../../core/store/app_state.dart';

List<Middleware<AppState>> createSearchMiddleware(SearchService service) {
  return [
    TypedMiddleware<AppState, SearchBooksAction>(
      _searchBooks(service),
    ),
  ];
}

Middleware<AppState> _searchBooks(SearchService service) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    try {
      print(  "Middleware: Initiating search for query: ${action.query} on page: ${action.page}");
      final response = await service.searchBooks(
        query: action.query,
        page: action.page,
      );

       print("Middleware: Search successful, dispatching success action.");
      store.dispatch(SearchBooksSuccessAction(
        results: response['books'],
        totalResults: response['totalResults'],
        totalPages: response['totalPages'],
        currentPage: response['currentPage'],
      ));
    } catch (e) {
      next(SearchBooksFailedAction(e.toString()));
    }
  };
}
