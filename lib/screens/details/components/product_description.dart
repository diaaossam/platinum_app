import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platinum_app/components/custom_card.dart';
import 'package:platinum_app/models/car_model.dart';
import 'package:platinum_app/screens/details/cubit/details_cubit.dart';
import 'package:platinum_app/screens/details/cubit/details_state.dart';
import 'package:platinum_app/screens/details/details_screen.dart';
import 'package:platinum_app/shared/helper/mangers/colors.dart';
import 'package:video_player/video_player.dart';

import '../../../shared/helper/mangers/size_config.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.carModel,
  }) : super(key: key);

  final CarModel carModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailsCubit, DetailsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        DetailsCubit cubit = DetailsCubit.get(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Text(
                carModel.title ?? '',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                width: getProportionateScreenWidth(64),
                decoration: BoxDecoration(
                  color:
                      carModel.isFav! ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    cubit.changeFav(
                        isFav: carModel.isFav ?? false, id: "${carModel.id}");
                  },
                  child: SvgPicture.asset(
                    "assets/icons/Heart Icon_2.svg",
                    color:
                        carModel.isFav! ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
                    height: getProportionateScreenWidth(16),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(20),
                right: getProportionateScreenWidth(64),
              ),
              child: Text(
                carModel.desc ?? '',
                maxLines: 3,
              ),
            ),
            CardItem(
                title: 'Country Registration',
                detials: carModel.countryReg ?? ''),
            SizedBox(
              height: getProportionateScreenHeight(10.0),
            ),
            CardItem(
                title: 'Engine Power', detials: carModel.enginePower ?? ''),
            SizedBox(
              height: getProportionateScreenHeight(10.0),
            ),
            CardItem(
                title: 'Mileage', detials: carModel.mileage ?? ''),
            SizedBox(
              height: getProportionateScreenHeight(10.0),
            ),
            CardItem(
                title: 'License Expiration Date', detials: carModel.licenseExpire ?? ''),
            SizedBox(
              height: getProportionateScreenHeight(10.0),
            ),
            CardItem(
                title: 'Year', detials: carModel.year ?? ''),
            SizedBox(
              height: getProportionateScreenHeight(10.0),
            ),
            CardItem(
                title: 'Color', detials: carModel.color ?? ''),
            SizedBox(
              height: getProportionateScreenHeight(10.0),
            ),
            CardItem(
                title: 'Fuel Type', detials: carModel.fuelType ?? ''),
            SizedBox(
              height: getProportionateScreenHeight(10.0),
            ),
            CardItem(
                title:'Number Of Owner', detials: carModel.number ?? ''),
            SizedBox(
              height: getProportionateScreenHeight(10.0),
            ),
            CardItem(
                title:'Problems', detials: carModel.problems ?? ''),
            SizedBox(
              height: getProportionateScreenHeight(10.0),
            ),
            CardItem(
                title:'Price', detials: carModel.price ?? ''),
            SizedBox(
              height: getProportionateScreenHeight(10.0),
            ),
          ],
        );
      },
    );
  }
}
