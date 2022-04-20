import 'package:flutter/material.dart';
import 'package:platinum_app/models/car_model.dart';

class ProductImage extends StatelessWidget {
  CarModel? carModel;

  ProductImage({required this.carModel});
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Hero(
        tag:"${carModel!.id}",
        child: Image.network(carModel!.images[0] ?? '', fit: BoxFit.cover),
      ),
    );
  }
}
