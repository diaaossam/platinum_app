import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platinum_app/components/app_text.dart';
import 'package:platinum_app/components/custom_text_form_field.dart';
import 'package:platinum_app/models/car_model.dart';
import 'package:platinum_app/screens/main_layout/cubit/main_cubit.dart';
import 'package:platinum_app/screens/main_layout/screens/sell_screen/components/drop_category.dart';
import 'package:platinum_app/shared/helper/mangers/colors.dart';
import 'package:platinum_app/shared/helper/mangers/constants.dart';
import 'package:platinum_app/shared/helper/methods.dart';
import 'package:tbib_toast/tbib_toast.dart';
import 'package:video_player/video_player.dart';
import '../../../../components/custom_button.dart';
import '../../../../shared/helper/icon_broken.dart';
import '../../../../shared/helper/mangers/size_config.dart';
import '../../../../shared/styles/styles.dart';
import 'components/fuel_type.dart';
import 'components/item_con.dart';

class SellCarScreen extends StatefulWidget {
  @override
  State<SellCarScreen> createState() => _SellCarScreenState();
}

class _SellCarScreenState extends State<SellCarScreen> {
  var title = TextEditingController();
  var price = TextEditingController();
  var desc = TextEditingController();

  var countryReg = TextEditingController();
  var enginePower = TextEditingController();
  var mileage = TextEditingController();
  var licenseExpire = TextEditingController();
  var year = TextEditingController();
  var color = TextEditingController();
  var number = TextEditingController();
  var problems = TextEditingController();


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
                        height: SizeConfigManger.bodyHeight * 0.10,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.productImages.isEmpty
                                ? 5
                                : cubit.productImages.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: SizeConfigManger.screenWidth * 0.18,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            getProportionateScreenWidth(18.0)),
                                    child: cubit.productImages.isNotEmpty
                                        ? Container(
                                      width: double.infinity,
                                          child: Image.file(File(
                                              cubit.productImages[index].path),fit: BoxFit.cover,),
                                        )
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
                    DropDownCategory(),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                    CustomTextFormField(
                        controller: countryReg,
                        lableText: 'Country registration *',
                        hintText: 'n'),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                    CustomTextFormField(
                        controller: enginePower,
                        lableText: 'Engine Power *',
                        hintText: 'n'),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                    CustomTextFormField(
                        controller: mileage,
                        lableText: 'mileage*',
                        hintText: 'n'),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                    CustomTextFormField(
                        controller: licenseExpire,
                        lableText: 'License Expiration Date',
                        hintText: 'n'),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                    CustomTextFormField(
                        controller: year, lableText: 'Year*', hintText: 'n'),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                    CustomTextFormField(
                        controller: color, lableText: 'Color', hintText: 'n'),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                    DropDownFuelType(),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                    CustomTextFormField(
                        controller: number,
                        lableText: 'Number Of Owner',
                        hintText: 'n'),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                    CustomTextFormField(
                        controller: problems,
                        lableText: 'Any car Problems ?',
                        hintText: 'n'),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                    AppText(text: 'License Status'),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: cubit.carTaxPaid,
                          activeColor: ColorsManger.primaryColor,
                          onChanged: (value) {
                            cubit.setUpCarTaxPaid();
                          },
                        ),
                        AppText(text: 'Car Text Paid ?'),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                    DropDownItemCondition(),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                    //done
                    buildProductPriceFormField(cubit),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                     buildProductDescprtionFormField(cubit),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                    buildProductTitleFormField(cubit),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                    CustomButton(
                        text: 'SUBMIT',
                        press: () {
                          if (formKey.currentState!.validate()) {
                            if (cubit.categoryText == null) {
                              Toast.show('Please Select Category Type', context,
                                  gravity: Toast.bottom);
                            } else if (cubit.productImages.length < 5) {
                              Toast.show('Please Select 5 Images', context,
                                  gravity: Toast.bottom);
                            } else if (productVedio == null) {
                              Toast.show('Please Select vedio', context,
                                  gravity: Toast.bottom);
                            } else {
                              cubit.uploadCarInfo(
                                  vedioFile: productVedio!,
                                  carModel: CarModel(
                                      year: year.text,
                                      video: ConstantsManger.DEFAULT,
                                      problems:problems.text ==null ? ConstantsManger.DEFAULT : problems.text,
                                      number: number.text ==null ? ConstantsManger.DEFAULT : number.text,
                                      mileage: mileage.text,
                                      licenseExpire: licenseExpire.text ==null ? ConstantsManger.DEFAULT : licenseExpire.text,
                                      itemCon: cubit.itemCon,
                                      fuelType: cubit.fuelType,
                                      enginePower: enginePower.text,
                                      countryReg: countryReg.text,
                                      color: color.text ==null ? ConstantsManger.DEFAULT : color.text,
                                      image: [],
                                      sellerId: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      title: title.text,
                                      price: price.text,
                                      desc: desc.text,
                                      type: cubit.categoryText,
                                      isFav: false));
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
        labelText: "Product Description *",
        floatingLabelBehavior: FloatingLabelBehavior.always,
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
        labelText: "Product Price *",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
