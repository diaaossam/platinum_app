import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../shared/helper/mangers/size_config.dart';
import '../shared/styles/styles.dart';


class CustomTextFormField extends StatelessWidget {
  bool isPassword;
  TextInputType? type;
  dynamic onChange;
  dynamic validate;
  dynamic onTap;
  dynamic onSaved;
  var controller;

  String lableText;
  String hintText;
  String? suffixIcon;

  CustomTextFormField(
      {this.isPassword = false,
      this.type = TextInputType.text,
      this.onChange,
      this.validate,
      this.onTap,
      this.onSaved,
      this.controller,
      required this.lableText,
      required this.hintText,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword == true ? true : false,
      keyboardType: type,
      onChanged: onChange,
      onSaved: onSaved,
      validator: validate,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: lableText,
        hintText: hintText == 'n'  ? null :hintText,
        border: ThemeManger.outlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        suffixIcon: suffixIcon == null
            ? null
            : Padding(
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset(
                  suffixIcon!,
                  height: getProportionateScreenHeight(20.0),
                  width: getProportionateScreenHeight(20.0),
                ),
              ),
      ),
    );
  }
}
