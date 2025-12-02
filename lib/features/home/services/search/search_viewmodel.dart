import 'package:penverse/core/models/book_model.dart';
import 'package:redux/redux.dart';

import 'search_actions.dart';
import '../../../../core/store/app_state.dart';

class SearchViewModel {
  final bool isLoading;
  final List<Book> results;
  final int totalResults;
  final String error;

  final Function(String query) search;

  SearchViewModel({
    required this.isLoading,
    required this.results,
    required this.totalResults,
    required this.error,
    required this.search,
  });

  factory SearchViewModel.fromStore(Store<AppState> store) {
    final state = store.state.searchState;

    return SearchViewModel(
      isLoading: state.isLoading,
      results: state.results,
      totalResults: state.totalResults,
      error: state.error,
      search: (query) {
        store.dispatch(SearchBooksAction(query));
      },
    );
  }
}
