class InitializeAuth {}

class RegisterAction {
  final String email;
  final String password;
  RegisterAction(this.email, this.password);
}

class LoginAction {
  final String email;
  final String password;
  LoginAction(this.email, this.password);
}

class LoginSuccess {
  final String email;
  LoginSuccess(this.email);
}

class LoginFailure {
  final String error;
  LoginFailure(this.error);
}

class Logout {}
