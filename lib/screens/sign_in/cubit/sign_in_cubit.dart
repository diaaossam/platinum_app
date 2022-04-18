import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/screens/sign_in/cubit/sign_in_state.dart';
import 'package:platinum_app/screens/sign_in/sign_in_screen.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  static SignInCubit get(context) => BlocProvider.of(context);

  bool isPasswordVisible = false;

  void changePasswordVisibaltySignIn() {
    isPasswordVisible = !isPasswordVisible;
    emit(ChangePasswordVisibilty());
  }

  final List<String?> errors = [];

  void setErrors(String error) {
    errors.add(error);
    emit(SetErrors());
  }

  void removeErrors(String error) {
    errors.remove(error);
    emit(RemoveErrors());
  }

  Future signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(SignInLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(SignInSuccessStateMainLayout());
    }).catchError((error) {
      print(error.toString());
      emit(SignInFailuerState(error.toString()));
    });
  }
}
