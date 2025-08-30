import 'auth_state.dart';
import 'auth_actions.dart';

AuthState authReducer(AuthState state, dynamic action) {
  if (action is LoginAction) {
    return state.copyWith(isLoading: true, errorMessage: null);
  } else if (action is LoginSuccess ) {
    return state.copyWith(isLoading: false, isLoggedIn: true);
  } else if (action is LoginFailure ) {
    return state.copyWith(isLoading: false, errorMessage: action.error);
  } else if (action is Logout) {
    return AuthState.initial();
  }
  return state;
}
