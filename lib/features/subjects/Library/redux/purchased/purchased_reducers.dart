import 'package:redux/redux.dart';
import 'purchased_books_state.dart';
import 'purchased_actions.dart';

final purchasedBookReducer = combineReducers<PurchasedBooksState>([
  TypedReducer<PurchasedBooksState, PurchasedBooksAction>(_onSearching),
  TypedReducer<PurchasedBooksState, PurchasedBooksSuccessAction>(_onSearchSuccess),
  TypedReducer<PurchasedBooksState, PurchasedBooksFailedAction>(_onSearchFailed),
]);

// When loading starts
PurchasedBooksState _onSearching(
    PurchasedBooksState state, PurchasedBooksAction action) {
  return state.copyWith(
    isLoading: true,
    error: '',
     
  );
}

// When API returns success
PurchasedBooksState _onSearchSuccess(
    PurchasedBooksState state, PurchasedBooksSuccessAction action) {
  
  final bool isFirstPage = action.currentPage == 1;

  return state.copyWith(
    isLoading: false,
    results: isFirstPage
        ? action.results                // fresh load
        : [...state.results, ...action.results], // pagination append
    totalResults: action.totalResults,
    totalPages: action.totalPages,
    currentPage: action.currentPage,
    error: '',
  );
}

// When API fails
PurchasedBooksState _onSearchFailed(
    PurchasedBooksState state, PurchasedBooksFailedAction action) {
  return state.copyWith(
    isLoading: false,
    error: action.error,
  );
}
