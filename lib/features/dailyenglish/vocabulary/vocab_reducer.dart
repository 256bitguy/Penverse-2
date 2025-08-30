import 'package:redux/redux.dart';
import 'vocab_state.dart';
import 'vocab_actions.dart';

final vocabReducer = combineReducers<VocabState>([
  TypedReducer<VocabState, LoadVocabAction>(_onLoad),
  TypedReducer<VocabState, LoadVocabSuccessAction>(_onLoadSuccess),
  TypedReducer<VocabState, LoadVocabFailureAction>(_onLoadFailure),
]);

VocabState _onLoad(VocabState state, LoadVocabAction action) {
  return state.copyWith(isLoading: true, error: null);
}

VocabState _onLoadSuccess(VocabState state, LoadVocabSuccessAction action) {
  return state.copyWith(
    isLoading: false,
    items: action.items,
    error: null,
  );
}

VocabState _onLoadFailure(VocabState state, LoadVocabFailureAction action) {
  return state.copyWith(isLoading: false, error: action.error);
}
