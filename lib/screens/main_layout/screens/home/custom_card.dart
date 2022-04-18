import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platinum_app/components/app_text.dart';

import '../../../../shared/helper/mangers/size_config.dart';


class CategoryCard extends StatelessWidget {
  String title;
  String image;
  final onTap;


  CategoryCard({required this.title,required  this.image,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child:  Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(10),
              vertical: getProportionateScreenHeight(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: SizeConfigManger.bodyHeight*0.17,
                  width: SizeConfigManger.bodyHeight*0.15,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(image)
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(10.0),),
                AppText(text: title,textSize: 25.0,),
              ],
            ),
          ),
      ),
    );
  }
}
class CategoryModel {
  String  title ;
  String image;

  CategoryModel({required this.title,required this.image});
}
