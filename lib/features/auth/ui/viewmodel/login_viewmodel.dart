 
import 'package:flutter/material.dart';
 
import '../../auth_actions.dart';
import '../../auth_selectors.dart';

class LoginViewModel {
  final bool isLoading;
  final bool isLoggedIn;
  final String? errorMessage;
  final void Function(String, String) onLogin;

  LoginViewModel({
    required this.isLoading,
    required this.isLoggedIn,
    required this.errorMessage,
    required this.onLogin,
  });

  factory LoginViewModel.fromStore(store, BuildContext context) {
    return LoginViewModel(
      isLoading: authLoadingSelector(store.state),
      isLoggedIn: isLoggedInSelector(store.state),
      errorMessage: authErrorSelector(store.state),
      onLogin: (email, password) {
        store.dispatch(LoginAction(email, password));
      },
    );
  }
}