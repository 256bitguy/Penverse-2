import 'package:redux/redux.dart';
import 'search_state.dart';
import 'search_actions.dart';
import '../../../subjects/book/redux/book_state.dart';

final searchReducer = combineReducers<SearchState>([
  TypedReducer<SearchState, SearchBooksAction>(_onSearching),
  TypedReducer<SearchState, SearchBooksSuccessAction>(_onSearchSuccess),
  TypedReducer<SearchState, SearchBooksFailedAction>(_onSearchFailed),
]);

SearchState _onSearching(SearchState state, SearchBooksAction action) {
  return state.copyWith(
    isLoading: true,
    error: '',
  );
}

SearchState _onSearchSuccess(
    SearchState state, SearchBooksSuccessAction action) {
 
  return state.copyWith(
    isLoading: false,
    results: action.results,
    totalResults: action.totalResults,
    totalPages: action.totalPages,
    currentPage: action.currentPage,
  );
}

SearchState _onSearchFailed(
    SearchState state, SearchBooksFailedAction action) {
  return state.copyWith(
    isLoading: false,
    error: action.error,
  );
}
