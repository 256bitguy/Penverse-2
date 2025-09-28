import 'package:redux/redux.dart';
import 'banking_awareness_state.dart';
import 'banking_awareness_actions.dart';

final bankingAwarenessReducer = combineReducers<BankingAwarenessState>([
  TypedReducer<BankingAwarenessState, FetchAwarenessByDateAction>(_onLoad),
  TypedReducer<BankingAwarenessState, LoadBankingAwarenessSuccessAction>(_onLoadSuccess),
  TypedReducer<BankingAwarenessState, LoadBankingAwarenessFailureAction>(_onLoadFailure),
]);

BankingAwarenessState _onLoad(
    BankingAwarenessState state, FetchAwarenessByDateAction action) {
  return state.copyWith(isLoading: true, error: null);
}

BankingAwarenessState _onLoadSuccess(
    BankingAwarenessState state, LoadBankingAwarenessSuccessAction action) {
  return state.copyWith(
    isLoading: false,
    items: action.items,
    error: null,
    isEmpty: action.items.isEmpty,  
  );

}

BankingAwarenessState _onLoadFailure(
    BankingAwarenessState state, LoadBankingAwarenessFailureAction action) {
  return state.copyWith(isLoading: false, error: action.error,items: [], isEmpty: true);
}
