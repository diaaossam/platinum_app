import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:platinum_app/screens/main_layout/cubit/main_cubit.dart';

import '../../../../../shared/helper/mangers/size_config.dart';

class DropDownFuelType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        return DropdownButtonHideUnderline(

          child: DropdownButton2(
            buttonDecoration: BoxDecoration(
                border: Border.all(color: Colors.grey,),
                borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            hint: Text(
              'Select Fuel Type *',
              style: TextStyle(
                fontSize: getProportionateScreenHeight(20.0),
                color: Theme
                    .of(context)
                    .hintColor,
              ),
            ),
            items: MainCubit
                .get(context)
                .fuelList
                .map((item) =>
                DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize:getProportionateScreenHeight(20.0),
                    ),
                  ),
                ))
                .toList(),
            value: MainCubit
                .get(context)
                .fuelType,
            onChanged: (value) {
              MainCubit.get(context).choosefuelType(value as String);
            },
            buttonHeight: getProportionateScreenHeight(50.0),
            buttonWidth: double.infinity,
            itemHeight: getProportionateScreenHeight(50.0),
          ),
        );
      },
    );
  }
}