import 'package:redux/redux.dart';
import 'upsc_state.dart';
import 'upsc_actions.dart';

final upscAwarenessReducer = combineReducers<UpscAwarenessState>([
  TypedReducer<UpscAwarenessState, LoadUpscAwarenessAction>(_onLoad),
  TypedReducer<UpscAwarenessState, LoadUpscAwarenessSuccessAction>(_onLoadSuccess),
  TypedReducer<UpscAwarenessState, LoadUpscAwarenessFailureAction>(_onLoadFailure),
]);

UpscAwarenessState _onLoad(
    UpscAwarenessState state, LoadUpscAwarenessAction action) {
  return state.copyWith(isLoading: false, error: null);
}

UpscAwarenessState _onLoadSuccess(
    UpscAwarenessState state, LoadUpscAwarenessSuccessAction action) {
  return state.copyWith(
    isLoading: false,
    items: action.items,
    error: null,
  );
}

UpscAwarenessState _onLoadFailure(
    UpscAwarenessState state, LoadUpscAwarenessFailureAction action) {
  return state.copyWith(isLoading: false, error: action.error);
}
