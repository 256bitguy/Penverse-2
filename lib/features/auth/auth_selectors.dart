// selectors/auth_selectors.dart
import '../../core/store/app_state.dart';
 

bool authLoadingSelector(AppState state) => state.authState.isLoading;
bool isLoggedInSelector(AppState state) => state.authState.isLoggedIn;
String? authErrorSelector(AppState state) => state.authState.errorMessage;
