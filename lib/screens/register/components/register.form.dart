import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/shared/styles/styles.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../shared/helper/mangers/constants.dart';
import '../../../shared/helper/mangers/size_config.dart';
import '../../../shared/helper/methods.dart';
import '../cubit/register_state.dart';
import '../cubit/regsiter_cubit.dart';

class RegisterForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? username;
  String? password;
  String? conform_password;

  void addError({required RegisterCubit cubit, String? error}) {
    if (!cubit.errors.contains(error)) cubit.setErrors(error!);
  }

  void removeError({required RegisterCubit cubit, String? error}) {
    if (cubit.errors.contains(error)) cubit.removeErrors(error!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoadingState)
            showCustomProgressIndicator(context);
          else if (state is RegisterSuccessState) {
            Navigator.pop(context);
            Navigator.pop(context);
          } else if (state is RegisterFailuerState) {
            Navigator.pop(context);
            String errorMsg = state.errorMsg;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 5),
            ));
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
          return Form(
            key: _formKey,
            child: Column(
              children: [
                buildUserNameFormField(cubit),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildEmailFormField(cubit),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildPasswordFormField(cubit),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildConformPassFormField(cubit),
                SizedBox(height: getProportionateScreenHeight(30)),
                FormError(errors: cubit.errors),
                SizedBox(height: getProportionateScreenHeight(40)),
                CustomButton(
                    text: "Register",
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        cubit.regiterNewUser(
                            email: email!, password: password!, username: '${username}');
                      }
                    }),
              ],
            ),
          );
        },
      ),
    );
  }

  TextFormField buildConformPassFormField(RegisterCubit cubit) {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(cubit: cubit, error: ConstantsManger.kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(cubit: cubit, error: ConstantsManger.kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(cubit: cubit, error: ConstantsManger.kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(cubit: cubit, error: ConstantsManger.kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        border: ThemeManger.outlineInputBorder(),
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField(RegisterCubit cubit) {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(cubit: cubit, error: ConstantsManger.kPassNullError);
        } else if (value.length >= 8) {
          removeError(cubit: cubit, error:ConstantsManger.kShortPassError);
        }
        password = value;
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
        border: ThemeManger.outlineInputBorder(),
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField(RegisterCubit cubit) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: ConstantsManger.kEmailNullError, cubit: cubit);
        } else if (ConstantsManger.emailValidatorRegExp.hasMatch(value)) {
          removeError(cubit: cubit, error: ConstantsManger.kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(cubit: cubit, error: ConstantsManger.kEmailNullError);
          return "";
        } else if (!ConstantsManger.emailValidatorRegExp.hasMatch(value)) {
          addError(cubit: cubit, error: ConstantsManger.kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        border: ThemeManger.outlineInputBorder(),

        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildUserNameFormField(RegisterCubit cubit) {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => username = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: ConstantsManger.kNamelNullError, cubit: cubit);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(cubit: cubit, error: ConstantsManger.kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "User Name",
        border: ThemeManger.outlineInputBorder(),
        hintText: "Enter your username",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }


}
