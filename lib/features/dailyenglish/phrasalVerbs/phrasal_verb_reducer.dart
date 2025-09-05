import 'package:redux/redux.dart';
import 'phrasal_verb_state.dart';
import 'phrasal_verbs_actions.dart';

final phrasalVerbsReducer = combineReducers<PhrasalVerbsState>([
  TypedReducer<PhrasalVerbsState, LoadPhrasalVerbsAction>(_onLoad),
  TypedReducer<PhrasalVerbsState, LoadPhrasalVerbsSuccessAction>(
      _onLoadSuccess),
  TypedReducer<PhrasalVerbsState, LoadPhrasalVerbsFailureAction>(
      _onLoadFailure),
]);

PhrasalVerbsState _onLoad(
    PhrasalVerbsState state, LoadPhrasalVerbsAction action) {
  return state.copyWith(isLoading: true, error: null);
}

PhrasalVerbsState _onLoadSuccess(
    PhrasalVerbsState state, LoadPhrasalVerbsSuccessAction action) {
  print(action.items);
  print("ye dekho yaha kaise handover kr rha");
  return state.copyWith(
    isLoading: false,
    items: action.items,
    error: null,
  );
}

PhrasalVerbsState _onLoadFailure(
    PhrasalVerbsState state, LoadPhrasalVerbsFailureAction action) {
  return state.copyWith(isLoading: false, error: action.error);
}
