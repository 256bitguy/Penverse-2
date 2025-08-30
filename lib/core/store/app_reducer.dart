import '../../features/auth/auth_reducers.dart';
import 'app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    authState: authReducer(state.authState, action),
  );
}
