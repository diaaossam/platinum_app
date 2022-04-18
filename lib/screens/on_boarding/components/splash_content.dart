import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platinum_app/components/app_text.dart';
import 'package:platinum_app/shared/helper/mangers/colors.dart';

import '../../../shared/helper/mangers/size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        AppText(
          text: 'Welcome To Platinum App',
          isTitle: true,
          color: ColorsManger.primaryColor,
          align: TextAlign.center,
        ),
        Spacer(
          flex: 1,
        ),
        AppText(
          text: text!,
          align: TextAlign.center,
          textSize: getProportionateScreenHeight(14),
        ),
        Spacer(flex: 2),
        SvgPicture.asset(image!,
            height: getProportionateScreenHeight(265),
            width: getProportionateScreenWidth(235))
      ],
    );
  }
}
