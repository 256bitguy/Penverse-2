class InitializeAuth {}

class RegisterAction {
  final String email;
  final String password;
  
  RegisterAction(this.email, this.password);
}
class RegisterSuccessAction {
  final Map<String, dynamic> response;
  RegisterSuccessAction(this.response);
} 
class RegisterFailureAction {
  final String error;
  RegisterFailureAction(this.error);
}
class LoginAction {
  final String email;
  final String password;
  LoginAction(this.email, this.password);
}

class LoginSuccessAction {
  final Map<String, dynamic> response;
  LoginSuccessAction(this.response);
}

class LoginFailureAction {
  final String error;
  LoginFailureAction(this.error);
}

class Logout {}
