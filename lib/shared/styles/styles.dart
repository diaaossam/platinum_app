import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../helper/mangers/size_config.dart';
import '../helper/mangers/colors.dart';

class ThemeManger {
  static ThemeData setLightTheme() {
    return ThemeData(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: ColorsManger.primaryColor,
        unselectedItemColor: Colors.grey,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: ColorsManger.primaryColor,
          primary: ColorsManger.primaryColor),
      scaffoldBackgroundColor: Colors.white,
    );
  }

  static OutlineInputBorder outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
      borderSide: BorderSide(color: Colors.black12),
    );
  }

}
