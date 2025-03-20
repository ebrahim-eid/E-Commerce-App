abstract class AuthStates {}

class AuthInitialState extends AuthStates {}
/// sign up
class SignUpLoadingState extends AuthStates {}

class SignUpSuccessState extends AuthStates {}

class SignUpErrorState extends AuthStates {
  final String error;

  SignUpErrorState(this.error);
}
/// logon
class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class LoginErrorState extends AuthStates {
  final String error;

  LoginErrorState(this.error);
}

/// Forgot password
class ForgotPasswordLoadingState extends AuthStates {}

class ForgotPasswordSuccessState extends AuthStates {}

class ForgotPasswordErrorState extends AuthStates {
  final String error;

  ForgotPasswordErrorState(this.error);
}

/// verify reset code
class VerifyResetCodeLoadingState extends AuthStates {}

class VerifyResetCodeSuccessState extends AuthStates {}

class VerifyResetCodeErrorState extends AuthStates {
  final String error;

  VerifyResetCodeErrorState(this.error);
}

///resetPassword
class ResetPasswordLoadingState extends AuthStates {}

class ResetPasswordSuccessState extends AuthStates {}

class ResetPasswordErrorState extends AuthStates {
  final String error;

  ResetPasswordErrorState(this.error);
}