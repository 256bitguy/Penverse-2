// features/auth/presentation/viewmodels/register_viewmodel.dart
 import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import '../../auth_actions.dart';
import '../../auth_selectors.dart';
import '../../../../core/store/app_state.dart';

class RegisterViewModel {
  final bool isLoading;
  final bool isRegistered = true;
  
  final String? errorMessage;
  final void Function(String, String) onRegister;

  RegisterViewModel({
    required this.isLoading,
    // required this.isRegistered ,
    required this.errorMessage,
    required this.onRegister,
  });

  factory RegisterViewModel.fromStore(Store<AppState> store) {
  return RegisterViewModel(
    isLoading: authLoadingSelector(store.state),
    // isRegistered: isRegisteredSelector(store.state),
    errorMessage: authErrorSelector(store.state),
    onRegister: (email, password) {
      print(  "RegisterViewModel: onRegister called with email: $email");
      store.dispatch(RegisterAction(email, password));
    },
  );
}

}
