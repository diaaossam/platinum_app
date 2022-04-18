import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/models/user_model.dart';
import 'package:platinum_app/screens/register/cubit/register_state.dart';
import 'package:platinum_app/shared/helper/mangers/constants.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  final List<String?> errors = [];

  void setErrors(String error) {
    errors.add(error);
    emit(SetErrors());
  }

  void removeErrors(String error) {
    errors.remove(error);
    emit(RemoveErrors());
  }

  void regiterNewUser(
      {required String email,
      required String password,
      required String username}) async {
    emit(RegisterLoadingState());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        UserModel userModel = UserModel(
            username: username,
            email: email,
            password: password,
            uid: value.user!.uid,);
        FirebaseFirestore.instance
            .collection(ConstantsManger.USERS)
            .doc(value.user!.uid)
            .set(userModel.toMap());
        emit(RegisterSuccessState());
      });
    } catch (e) {
      emit(RegisterFailuerState(e.toString()));
    }
  }
}
