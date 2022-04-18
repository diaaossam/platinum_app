import 'package:flutter/material.dart';
import 'package:platinum_app/screens/register/components/register.form.dart';

import '../../../shared/helper/mangers/size_config.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              "Sign in with your email and password  \nor continue with social media",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfigManger.bodyHeight * 0.08),
            RegisterForm(),
            SizedBox(height: SizeConfigManger.bodyHeight * 0.08),
          ],
        ),
      ),
    );
  }
}
