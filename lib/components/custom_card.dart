
import 'package:flutter/material.dart';

import '../shared/helper/mangers/size_config.dart';
class CardItem extends StatelessWidget {
  String title;
  String detials;


  CardItem({required this.title,required this.detials});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(14),
          vertical: getProportionateScreenHeight(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: getProportionateScreenWidth(25)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '${title}',
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(17),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Text(
                  '${detials}',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: getProportionateScreenWidth(12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}