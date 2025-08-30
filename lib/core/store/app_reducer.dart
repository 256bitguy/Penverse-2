import '../../features/auth/auth_reducers.dart';
import '../../features/dailyenglish/vocabulary/vocab_reducer.dart';
import 'app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    authState: authReducer(state.authState, action),
    vocabState: vocabReducer(state.vocabState, action),
  );
}
