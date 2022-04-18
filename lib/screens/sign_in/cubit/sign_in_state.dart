
abstract class SignInState {}

class SignInInitial extends SignInState {}
class ChangePasswordVisibilty extends SignInState {}
class SetErrors extends SignInState {}
class RemoveErrors extends SignInState {}


class SignInLoadingState extends SignInState {}
class SignInSuccessStateMainLayout extends SignInState {}
class SignInFailuerState extends SignInState {
  String error;
  SignInFailuerState(this.error);
}
