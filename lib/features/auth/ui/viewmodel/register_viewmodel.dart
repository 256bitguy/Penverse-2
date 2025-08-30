// features/auth/presentation/viewmodels/register_viewmodel.dart
import 'package:flutter/material.dart';
 
import '../../auth_actions.dart';
import '../../auth_selectors.dart';

class RegisterViewModel {
  final bool isLoading;
  final bool isLoggedIn;
  final String? errorMessage;
  final void Function(String, String) onRegister;

  RegisterViewModel({
    required this.isLoading,
    required this.isLoggedIn,
    required this.errorMessage,
    required this.onRegister,
  });

  factory RegisterViewModel.fromStore(store, BuildContext context) {
    return RegisterViewModel(
      isLoading: authLoadingSelector(store.state),
      isLoggedIn: isLoggedInSelector(store.state),
      errorMessage: authErrorSelector(store.state),
      onRegister: (email, password) {
        store.dispatch(RegisterAction(email, password));
      },
    );
  }
}
