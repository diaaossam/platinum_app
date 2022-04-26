import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/components/custom_button.dart';
import 'package:platinum_app/components/custom_text_form_field.dart';
import 'package:platinum_app/screens/main_layout/cubit/main_cubit.dart';
import 'package:platinum_app/screens/sign_in/sign_in_screen.dart';
import 'package:platinum_app/shared/helper/mangers/colors.dart';
import 'package:platinum_app/shared/helper/mangers/constants.dart';
import 'package:platinum_app/shared/helper/mangers/size_config.dart';
import 'package:platinum_app/shared/helper/methods.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  var fullName = TextEditingController();
  var email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is SignOutSuccess) {
          navigateToAndFinish(context, SignInScreen());
        }
      },
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return state is LoadingUser
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: SizeConfigManger.bodyHeight * .105,
                                backgroundColor: ColorsManger.primaryColor,
                              ),
                              CircleAvatar(
                                radius: SizeConfigManger.bodyHeight * .1,
                                backgroundColor: Colors.white,
                                backgroundImage: setImage(cubit),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            backgroundColor: ColorsManger.primaryColor,
                            radius: getProportionateScreenHeight(25.0),
                            child: IconButton(
                                onPressed: () {
                                  cubit.getProfileImage();
                                },
                                icon: Icon(Icons.camera_alt)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfigManger.bodyHeight * 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          CustomTextFormField(
                            lableText: 'Full Name',
                            hintText: 'n',
                            controller: fullName
                              ..text = cubit.userModel!.username ?? '',
                          ),
                          SizedBox(
                            height: SizeConfigManger.bodyHeight * 0.04,
                          ),
                          CustomTextFormField(
                              controller: email
                                ..text = cubit.userModel!.email ?? '',
                              lableText: 'Email Or Phone Number',
                              hintText: 'n'),
                          SizedBox(height: SizeConfigManger.bodyHeight * 0.1),
                          CustomButton(
                            text: 'Save Changes',
                            press: () {
                              if(email.text != cubit.userModel!.email){

                              }
                              if(fullName.text != cubit.userModel!.username){

                              };
                            },
                          ),
                          SizedBox(
                            height: SizeConfigManger.bodyHeight * 0.04,
                          ),
                          CustomButton(
                            text: 'Sign Out',
                            press: () {
                              cubit.signOut();
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ));
      },
    );
  }
//2
  ImageProvider setImage(MainCubit cubit) {
    if ("${cubit.userModel!.image}" == ConstantsManger.DEFAULT) {
      return AssetImage('assets/images/user.png');
    } else {
      if (cubit.profileImage != null) {
        return FileImage(cubit.profileImage ?? File(''));
      } else {
        return NetworkImage(cubit.userModel!.image ?? '');
      }
    }
  }
}
