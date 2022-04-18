import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/screens/main_layout/cubit/main_cubit.dart';
import 'package:platinum_app/screens/sign_in/cubit/sign_in_cubit.dart';
import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text("Sign In"),),
        body: Body(),
      ),
    );
  }
}
