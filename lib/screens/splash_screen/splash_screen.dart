import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/screens/main_layout/main_layout_screen.dart';
import 'package:platinum_app/screens/on_boarding/on_boarding_screen.dart';
import 'package:platinum_app/screens/sign_in/sign_in_screen.dart';
import 'package:platinum_app/shared/helper/mangers/assets_manger.dart';
import 'package:platinum_app/shared/helper/methods.dart';
import 'package:platinum_app/shared/helper/mangers/colors.dart';
import '../../components/app_text.dart';
import '../../shared/helper/mangers/size_config.dart';
import 'cubit/splash_cubit.dart';
import 'package:lottie/lottie.dart';


class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SizeConfigManger().init(context);
    return BlocProvider(
      create: (context) =>
      SplashCubit()
        ..checkUserState(context),
      child: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashLoginState) {
            navigateToAndFinish(context, SignInScreen());
          }
          else if (state is SplashMainLayoutState) {
            navigateToAndFinish(context, MainLayout());
          } else if (state is SplashOnBoardingState) {
            navigateToAndFinish(context, OnBoardingScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: SizeConfigManger.bodyHeight * 0.3),
                  SizedBox(height: getProportionateScreenHeight(25.0)),
                  Center(
                    child: Container(
                        width: getProportionateScreenHeight(250.0),
                        height: getProportionateScreenHeight(250.0),
                        child: Lottie.asset(AssetsManger.AppLogo)
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(25.0)),
                  AppText(text: "Platinum App",
                      isTitle: true,
                      color: ColorsManger.primaryColor),
                  Spacer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
