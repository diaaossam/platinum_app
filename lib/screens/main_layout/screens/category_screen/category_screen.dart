import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/components/app_text.dart';
import 'package:platinum_app/models/car_model.dart';
import 'package:platinum_app/screens/main_layout/screens/category_screen/cubit/category_cubit.dart';
import 'package:platinum_app/shared/helper/mangers/colors.dart';
import 'package:platinum_app/shared/helper/mangers/size_config.dart';

import '../../../../shared/helper/methods.dart';
import '../../../../shared/styles/styles.dart';

class CategoryScreen extends StatelessWidget {
  String type;

  CategoryScreen(this.type);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit()..getCars(type),
      child: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {
          if (state is AddCarToFavSuccess) {
            showSnackBar(context, 'Car Added To Favourite List');
          } else if (state is RemoveCarFromFavSuccess) {
            showSnackBar(context, 'Car Removed From Favourite List ');
          }
        },
        builder: (context, state) {
          CategoryCubit cubit = CategoryCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: AppText(text: type, isTitle: true),
              centerTitle: true,
            ),
            body: state is GetCarsLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : cubit.carsList.length == 0
                    ? Center(
                        child: AppText(
                          text: 'No Cars',
                          isTitle: true,
                          color: Colors.grey,
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: SizeConfigManger.bodyHeight * 0.04,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: buildSearchTextFormField(cubit),
                          ),
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
                                    cubit.carsList.length,
                                    (index) => productsView(
                                        model: cubit.carsList[index],
                                        cubit: cubit))),
                          ),
                        ],
                      ),
          );
        },
      ),
    );
  }

  TextFormField buildSearchTextFormField(CategoryCubit cubit) {
    return TextFormField(
      keyboardType: TextInputType.text,
      onChanged: (String value) {
        if (value != null) cubit.getSearchData(type, value);
      },
      decoration: InputDecoration(
        border: ThemeManger.outlineInputBorder(),
        suffixIcon: Icon(Icons.search),
        hintText: ('type to search ...'),
      ),
    );
  }

  Widget productsView(
      {required CarModel? model, required CategoryCubit cubit}) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenHeight(10.0)),
        child: Container(
          height: SizeConfigManger.bodyHeight*0.5,
          width: SizeConfigManger.bodyHeight*0.5,
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
                AppText(text: model.title ?? '',textSize: 24.0),
                SizedBox(
                  height: getProportionateScreenHeight(5),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: getProportionateScreenHeight(10.0)),
                      child: AppText(text:
                        "${model.price} EGP",
                        textSize: 18.0,

                      ),
                    ),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor: model.isFav == true
                          ? ColorsManger.FavColor
                          : Colors.grey[300],
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          cubit.changeFav(
                              isFav: model.isFav ?? false, id: "${model.id}");
                        },
                      ),
                    ),
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
