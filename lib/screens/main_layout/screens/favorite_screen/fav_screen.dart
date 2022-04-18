import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/screens/main_layout/cubit/main_cubit.dart';
import 'package:platinum_app/shared/helper/icon_broken.dart';

import '../../../../components/app_text.dart';
import '../../../../models/car_model.dart';
import '../../../../shared/helper/mangers/colors.dart';
import '../../../../shared/helper/mangers/size_config.dart';
import '../../../../shared/helper/methods.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
       if (state is RemoveCarFavourtie) {
          showSnackBar(context, 'Car Removed From Favourite List ');
        }
      },
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        print(cubit.favCarList.length);
        return state is GetFavourtieCarsLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : cubit.favCarList.length == 0
                ? Center(
                    child: AppText(
                      text: 'No Favourite Cars',
                      isTitle: true,
                      color: Colors.grey,
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: SizeConfigManger.bodyHeight * 0.04,
                      ),
                      Expanded(
                        child: GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: .85,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            children: List.generate(
                                cubit.favCarList.length,
                                (index) => productsView(
                                    model: cubit.favCarList[index],
                                    cubit: cubit))),
                      ),
                    ],
                  );
      },
    );
  }

  Widget productsView({required CarModel? model, required MainCubit cubit}) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenHeight(10.0)),
        child: Container(
          height: SizeConfigManger.bodyHeight * 0.5,
          width: SizeConfigManger.bodyHeight * 0.5,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            getProportionateScreenHeight(8.0)),
                        image: DecorationImage(
                            image: NetworkImage('${model!.image}'),
                            fit: BoxFit.cover)),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                AppText(text: model.title ?? '', textSize: 24.0),
                SizedBox(
                  height: getProportionateScreenHeight(5),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: getProportionateScreenHeight(10.0)),
                      child: AppText(
                        text: "${model.price} EGP",
                        textSize: 18.0,
                      ),
                    ),
                    Spacer(),
                    IconButton(icon: Icon(IconBroken.Delete), onPressed: () {
                      cubit.removeItemFromFav(model.id??'');
                    }),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
