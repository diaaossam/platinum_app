
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class SetErrors extends RegisterState {}
class RemoveErrors extends RegisterState {}


class RegisterLoadingState extends RegisterState {}
class RegisterSuccessState extends RegisterState {}
class RegisterFailuerState extends RegisterState {
  String errorMsg;
  RegisterFailuerState(this.errorMsg);
}
