import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../shared/helper/mangers/constants.dart';
import '../../../shared/services/local/cache_helper.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  static SplashCubit get(BuildContext context) => BlocProvider.of(context);

  void checkUserState(context) {
    Future.delayed(Duration(seconds: 3), () {
      bool onBoarding =
          CachedHelper.getBooleon(key: ConstantsManger.ON_BOARDING) ?? false;
      if (onBoarding == true) {
        FirebaseAuth.instance.authStateChanges().listen((user) {
          if (user != null) {
            emit(SplashMainLayoutState());
          } else {
            emit(SplashLoginState());
          }
        });
      } else {
        emit(SplashOnBoardingState());
      }
    });
  }
}
