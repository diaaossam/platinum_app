import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/models/car_model.dart';
import 'package:platinum_app/screens/details/cubit/details_cubit.dart';
import 'package:platinum_app/screens/details/cubit/details_state.dart';
import 'package:video_player/video_player.dart';
import '../../../components/custom_button.dart';
import '../../../shared/helper/mangers/size_config.dart';
import '../../../shared/helper/methods.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatefulWidget {
  final CarModel? carModel;

  const Body({Key? key, required this.carModel}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.carModel!.video ?? '')
      ..initialize().then((value) {
        setState(() {});
      });
  }

//Ok
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailsCubit>(
      create: (BuildContext context) =>
      DetailsCubit()
        ..getCarDetails(id: "${widget.carModel!.id}"),
      child: BlocConsumer<DetailsCubit, DetailsState>(
        listener: (context, state) {
          if (state is AddCarToFavSuccess) {
            showSnackBar(context, 'Car Added To Favourite List');
          } else if (state is RemoveCarFromFavSuccess) {
            showSnackBar(context, 'Car Removed From Favourite List ');
          }
        },
        builder: (context, state) {
          DetailsCubit cubit = DetailsCubit.get(context);
          return state is GetCarModelLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : ListView(
            children: [
              ProductImages(carModel: cubit.carModel!),
              Center(child: _controller!.value.isInitialized ? AspectRatio(
                aspectRatio: 16.0 / 21.0, child:VideoPlayer(_controller!),):Center()),
              TopRoundedContainer(
                color: Colors.white,
                child: Column(
                  children: [
                    ProductDescription(
                      carModel: cubit.carModel!,
                    ),
                    TopRoundedContainer(
                      color: Color(0xFFF6F7F9),
                      child: Column(
                        children: [
                          TopRoundedContainer(
                            color: Colors.white,
                            child: Padding(
                                padding: EdgeInsets.only(
                                  left:
                                  SizeConfigManger.screenWidth * 0.15,
                                  right:
                                  SizeConfigManger.screenWidth * 0.15,
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
