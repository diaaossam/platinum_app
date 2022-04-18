import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/shared/helper/mangers/colors.dart';
import 'package:platinum_app/shared/helper/mangers/constants.dart';
import 'package:platinum_app/shared/styles/styles.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../shared/helper/keyboard.dart';
import '../../../shared/helper/mangers/size_config.dart';
import '../../../shared/helper/methods.dart';
import '../../main_layout/main_layout_screen.dart';
import '../cubit/sign_in_cubit.dart';
import '../cubit/sign_in_state.dart';

class SignForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  void addError({required SignInCubit cubit, String? error}) {
    if (!cubit.errors.contains(error)) cubit.setErrors(error!);
  }

  void removeError({required SignInCubit cubit, String? error}) {
    if (cubit.errors.contains(error)) cubit.removeErrors(error!);
  }

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
        SignInCubit cubit = SignInCubit.get(context);
        return Form(
          key: _formKey,
          child: Column(
            children: [
              buildEmailFormField(cubit),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildPasswordFormField(cubit),
              SizedBox(height: getProportionateScreenHeight(30)),
              Row(
                children: [
                  Checkbox(
                    value: cubit.isPasswordVisible,
                    activeColor: ColorsManger.primaryColor,
                    onChanged: (value) {
                      cubit.changePasswordVisibaltySignIn();
                    },
                  ),
                  Text("Show Password"),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      //navigateTo(context, ForgotPasswordScreen());
                    },
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
              FormError(errors: cubit.errors),
              SizedBox(height: getProportionateScreenHeight(20)),
              CustomButton(
                  text: 'Login In',
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      KeyboardUtil.hideKeyboard(context);
                      cubit.signInWithEmailAndPassword(email: email!,
                          password: password!,
                         );
                    }
                  }),
            ],
          ),
        );
      },
    );
  }

  TextFormField buildPasswordFormField(SignInCubit cubit) {
    return TextFormField(
      obscureText: !cubit.isPasswordVisible,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(cubit: cubit, error: ConstantsManger.kPassNullError);
        } else if (value.length >= 8) {
          removeError(cubit: cubit, error:ConstantsManger.kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(cubit: cubit, error: ConstantsManger.kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(cubit: cubit, error: ConstantsManger.kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        border: ThemeManger.outlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField( SignInCubit cubit) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(cubit: cubit, error: ConstantsManger.kEmailNullError);
        } else if ( ConstantsManger.emailValidatorRegExp.hasMatch(value)) {
          removeError(cubit: cubit, error:  ConstantsManger.kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(cubit: cubit, error:  ConstantsManger.kEmailNullError);
          return "";
        } else if (! ConstantsManger.emailValidatorRegExp.hasMatch(value)) {
          addError(cubit: cubit, error:  ConstantsManger.kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        border: ThemeManger.outlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
