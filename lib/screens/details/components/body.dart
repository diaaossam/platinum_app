import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/models/car_model.dart';
import 'package:platinum_app/screens/details/cubit/details_cubit.dart';
import 'package:platinum_app/screens/details/cubit/details_state.dart';
import '../../../components/custom_button.dart';
import '../../../shared/helper/mangers/size_config.dart';
import '../../../shared/helper/methods.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final CarModel? carModel;

  const Body({Key? key, required this.carModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailsCubit>(
      create: (BuildContext context)=>DetailsCubit()..getCarDetails(id: "${carModel!.id}"),
          child: BlocConsumer<DetailsCubit,DetailsState>(
        listener: (context, state) {
          if (state is AddCarToFavSuccess) {
            showSnackBar(context, 'Car Added To Favourite List');
          } else if (state is RemoveCarFromFavSuccess) {
            showSnackBar(context, 'Car Removed From Favourite List ');
          }
        },
        builder: (context, state) {
          DetailsCubit cubit = DetailsCubit.get(context);
          return state is GetCarModelLoading ?Center(child: CircularProgressIndicator(),):ListView(
            children: [
              ProductImage(carModel: cubit.carModel!),
              TopRoundedContainer(
                color: Colors.white,
                child: Column(
                  children: [
                    ProductDescription(
                      pressOnSeeMore: () {},
                      carModel:cubit.carModel!,
                    ),
                    TopRoundedContainer(
                      color: Color(0xFFF6F7F9),
                      child: Column(
                        children: [
                          TopRoundedContainer(
                            color: Colors.white,
                            child: Padding(
                                padding: EdgeInsets.only(
                                  left: SizeConfigManger.screenWidth * 0.15,
                                  right: SizeConfigManger.screenWidth * 0.15,
                                  bottom: getProportionateScreenWidth(40),
                                  top: getProportionateScreenWidth(15),
                                ),
                                child: CustomButton(
                                  press: () {},
                                  text: 'Buy This Car',
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
