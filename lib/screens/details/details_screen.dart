import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/models/car_model.dart';
import 'package:platinum_app/screens/details/cubit/details_cubit.dart';
import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  CarModel? carModel;

  DetailsScreen({required this.carModel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Color(0xFFF5F6F9),
          body: Body(carModel: carModel),

    );
  }
}
