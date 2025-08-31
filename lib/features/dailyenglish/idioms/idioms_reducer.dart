import 'package:redux/redux.dart';
import 'idioms_state.dart';
import 'idioms_actions.dart';

final idiomsReducer = combineReducers<IdiomsState>([
  TypedReducer<IdiomsState, LoadIdiomsAction>(_onLoad),
  TypedReducer<IdiomsState, LoadIdiomsSuccessAction>(_onLoadSuccess),
  TypedReducer<IdiomsState, LoadIdiomsFailureAction>(_onLoadFailure),
]);

IdiomsState _onLoad(IdiomsState state, LoadIdiomsAction action) {
  return state.copyWith(isLoading: true, error: null);
}

IdiomsState _onLoadSuccess(IdiomsState state, LoadIdiomsSuccessAction action) {
  return state.copyWith(
    isLoading: false,
    items: action.items,
    error: null,
  );
}

IdiomsState _onLoadFailure(IdiomsState state, LoadIdiomsFailureAction action) {
  return state.copyWith(isLoading: false, error: action.error);
}
