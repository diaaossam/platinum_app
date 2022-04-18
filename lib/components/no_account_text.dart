import 'package:flutter/material.dart';
import 'package:platinum_app/shared/helper/mangers/colors.dart';

import '../screens/register/register.dart';
import '../shared/helper/mangers/size_config.dart';
import '../shared/helper/methods.dart';



class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: (){
            navigateTo(context, RegisterScreen());
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: ColorsManger.primaryColor),
          ),
        ),
      ],
    );
  }
}
