import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/no_account_text.dart';
import '../../../shared/helper/mangers/size_config.dart';
import '../../../shared/helper/methods.dart';
import '../../main_layout/main_layout_screen.dart';
import '../cubit/sign_in_cubit.dart';
import '../cubit/sign_in_state.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {

        if(state is SignInLoadingState){
          showCustomProgressIndicator(context);
        }
        else if(state is SignInFailuerState){
          Navigator.pop(context);
          String errorMsg = state.error;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(errorMsg),
            backgroundColor: Colors.black,
            duration: Duration(seconds: 5),
          ));
        }
        else if(state is SignInSuccessStateMainLayout){
          Navigator.pop(context);
          navigateToAndFinish(context,MainLayout());
        }
      },
      builder: (context, state) {
        return Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfigManger.bodyHeight * 0.04),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sign in with your email and password",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfigManger.bodyHeight * 0.08),
                SignForm(),
                SizedBox(height: getProportionateScreenHeight(20)),
                NoAccountText(),
              ],
            ),
          ),
        );
      },
    );
  }
}
