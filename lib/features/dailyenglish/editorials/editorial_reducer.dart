import 'package:redux/redux.dart';
import 'editorial_state.dart';
import 'editorial_actions.dart';

final editorialReducer = combineReducers<EditorialState>([
  TypedReducer<EditorialState, LoadEditorialAction>(_onLoad),
  TypedReducer<EditorialState, LoadEditorialSuccessAction>(_onLoadSuccess),
  TypedReducer<EditorialState, LoadEditorialFailureAction>(_onLoadFailure),
]);

EditorialState _onLoad(EditorialState state, LoadEditorialAction action) {
  return state.copyWith(isLoading: true, error: null);
}

EditorialState _onLoadSuccess(EditorialState state, LoadEditorialSuccessAction action) {
  return state.copyWith(
    isLoading: false,
    items: action.items,
    error: null,
  );
}

EditorialState _onLoadFailure(EditorialState state, LoadEditorialFailureAction action) {
  return state.copyWith(isLoading: false, error: action.error);
}
