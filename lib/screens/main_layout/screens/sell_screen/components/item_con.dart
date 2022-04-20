import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:platinum_app/screens/main_layout/cubit/main_cubit.dart';

import '../../../../../shared/helper/mangers/size_config.dart';

class DropDownItemCondition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text(
              'Select Item Condition',
              style: TextStyle(
                fontSize: getProportionateScreenHeight(20.0),
                color: Theme
                    .of(context)
                    .hintColor,
              ),
            ),
            items: MainCubit
                .get(context)
                .itemConList
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
                .itemCon,
            onChanged: (value) {
              MainCubit.get(context).chooseItemCon(value as String);
            },
            buttonHeight: getProportionateScreenHeight(50.0),
            buttonWidth: getProportionateScreenHeight(240),
            itemHeight: getProportionateScreenHeight(50.0),
          ),
        );
      },
    );
  }
}