import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/screens/main_layout/cubit/main_cubit.dart';
import 'package:platinum_app/screens/main_layout/screens/category_screen/category_screen.dart';
import 'package:platinum_app/screens/main_layout/screens/home/custom_card.dart';
import 'package:platinum_app/shared/helper/mangers/assets_manger.dart';
import 'package:platinum_app/shared/helper/mangers/constants.dart';
import 'package:platinum_app/shared/helper/mangers/size_config.dart';
import 'package:platinum_app/shared/helper/methods.dart';

import '../../../../shared/styles/styles.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return SafeArea(
          child: Padding(
            padding:  EdgeInsets.all(getProportionateScreenHeight(15.0)),
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(20.0),
                ),
                buildSearchTextFormField(cubit),
                SizedBox(
                  height: getProportionateScreenHeight(20.0),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: .85,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: <Widget>[
                      CategoryCard(
                          title: 'Van',
                          image: AssetsManger.van,
                          onTap: () {
                            navigateTo(context, CategoryScreen(ConstantsManger.VAN));
                          }),
                      CategoryCard(
                          title: 'Sedan',
                          image: AssetsManger.sedan,
                          onTap: () {
                            navigateTo(context, CategoryScreen(ConstantsManger.sedan));

                          }),
                      CategoryCard(
                          title: 'SUV',
                          image: AssetsManger.suv,
                          onTap: () {
                            navigateTo(context, CategoryScreen(ConstantsManger.suv));

                          }),
                      CategoryCard(
                          title: 'MotorCycle',
                          image: AssetsManger.motor,
                          onTap: () {
                            navigateTo(context, CategoryScreen(ConstantsManger.motor));
                          }),
                      CategoryCard(
                          title: 'PickUp',
                          image: AssetsManger.pick_up,
                          onTap: () {
                            navigateTo(context, CategoryScreen(ConstantsManger.pick_up));
                          }),
                      CategoryCard(
                          title: 'Coupe',
                          image: AssetsManger.coupe,
                          onTap: () {
                            navigateTo(context, CategoryScreen(ConstantsManger.coupe));
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  TextFormField buildSearchTextFormField(MainCubit cubit) {
    return TextFormField(
      keyboardType: TextInputType.text,
      onChanged: (String value) {
        if (value != null) cubit.getSearchData(searchText: value);
      },
      decoration: InputDecoration(
        border: ThemeManger.outlineInputBorder(),
        suffixIcon: Icon(Icons.search),
        hintText: ('type to search ...'),
      ),
    );
  }
}
