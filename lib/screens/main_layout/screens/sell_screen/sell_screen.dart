import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platinum_app/models/car_model.dart';
import 'package:platinum_app/screens/main_layout/cubit/main_cubit.dart';
import 'package:platinum_app/screens/main_layout/screens/sell_screen/components/drop_category.dart';
import 'package:platinum_app/shared/helper/mangers/constants.dart';
import 'package:platinum_app/shared/helper/methods.dart';
import 'package:tbib_toast/tbib_toast.dart';
import 'package:video_player/video_player.dart';
import '';
import '../../../../components/custom_button.dart';
import '../../../../shared/helper/icon_broken.dart';
import '../../../../shared/helper/mangers/size_config.dart';
import '../../../../shared/styles/styles.dart';

class SellCarScreen extends StatefulWidget {
  @override
  State<SellCarScreen> createState() => _SellCarScreenState();
}

class _SellCarScreenState extends State<SellCarScreen> {
  var title = TextEditingController();
  var price = TextEditingController();
  var desc = TextEditingController();
  var formKey = GlobalKey<FormState>();

  VideoPlayerController? controller;
  var picker = ImagePicker();
  File? productVedio;

  Future getproductVedio() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      productVedio = File(pickedFile.path);
      controller = VideoPlayerController.file(productVedio!)
        ..initialize().then((value) {
          if (controller!.value.duration > Duration(minutes: 1)) {
            setState(() {});
            controller!.play();
          } else {
            Toast.show('Error Vedio Should Be More than 1 minute', context,
                duration: 3);
          }
        });
    }
  }

  //done here1
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is UploadCarInfoSuccess) {
          showSnackBar(context, 'Success Upload Car ');
        }
      },
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return Form(
          key: formKey,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(20.0),
                    horizontal: getProportionateScreenHeight(20.0)),
                child: Column(
                  children: [
                    state is UploadCarInfoLoading
                        ? LinearProgressIndicator()
                        : Container(),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                    InkWell(
                      onTap: () {
                        cubit.getproductImages();
                      },
                      child: Container(
                        width: double.infinity,
                        height: SizeConfigManger.bodyHeight * 0.12,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.productImages.isEmpty
                                ? 5
                                : cubit.productImages.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            getProportionateScreenWidth(18.0)),
                                    child: cubit.productImages.isNotEmpty
                                        ? Image.file(File(
                                            cubit.productImages[index].path))
                                        : Icon(
                                            CupertinoIcons.camera,
                                            size: getProportionateScreenHeight(
                                                20.0),
                                          )),
                              );
                            }),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                    InkWell(
                      onTap: () {
                        getproductVedio();
                      },
                      child: productVedio != null
                          ? AspectRatio(
                              aspectRatio: 16.0 / 21.0,
                              child: VideoPlayer(controller!),
                            )
                          : Icon(
                              CupertinoIcons.video_camera,
                              size: getProportionateScreenHeight(100.0),
                            ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                    buildProductTitleFormField(cubit),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                    buildProductDescprtionFormField(cubit),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenHeight(80.0)),
                      child: buildProductPriceFormField(cubit),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                    DropDownCategory(),
                    SizedBox(
                      height: getProportionateScreenHeight(40.0),
                    ),
                    CustomButton(
                        text: 'Confirm',
                        press: () {
                          if (formKey.currentState!.validate()) {
                            if (cubit.categoryText == null) {
                              Toast.show('Please Select Category Type', context,
                                  gravity: Toast.bottom);
                            } else {
                              if (cubit.productImages.length < 5) {
                                Toast.show('Please Select 5 Images', context,
                                    gravity: Toast.bottom);
                              } else {
                                cubit.uploadCarInfo(
                                    carModel: CarModel(
                                        images: [],
                                        sellerId: FirebaseAuth
                                            .instance.currentUser!.uid,
                                        title: title.text,
                                        price: price.text,
                                        desc: desc.text,
                                        type: cubit.categoryText,
                                        isFav: false));
                              }
                            }
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  TextFormField buildProductTitleFormField(MainCubit cubit) {
    return TextFormField(
      controller: title,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Product Title";
        }
        return null;
      },
      decoration: InputDecoration(
        border: ThemeManger.outlineInputBorder(),
        labelText: "Product Title",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(IconBroken.Ticket),
      ),
    );
  }

  TextFormField buildProductDescprtionFormField(MainCubit cubit) {
    return TextFormField(
      controller: desc,
      maxLines: 3,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Product Descrption";
        }
        return null;
      },
      decoration: InputDecoration(
        border: ThemeManger.outlineInputBorder(),
        labelText: "Product Description",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(IconBroken.Ticket),
      ),
    );
  }

  TextFormField buildProductPriceFormField(MainCubit cubit) {
    return TextFormField(
      controller: price,
      maxLines: 1,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Product Price";
        }
        return null;
      },
      decoration: InputDecoration(
        border: ThemeManger.outlineInputBorder(),
        labelText: "Product Price",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(IconBroken.Ticket),
      ),
    );
  }
}
