import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/models/car_model.dart';
import 'package:platinum_app/screens/details/cubit/details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  CarModel ? carModel;
  DetailsCubit() : super(InitialState());

  static DetailsCubit get(BuildContext context) => BlocProvider.of(context);


  void getCarDetails({required String id}){
    emit(GetCarModelLoading());
    FirebaseFirestore.instance.collection('cars').doc(id).snapshots().listen((event) {
      carModel = CarModel.fromJson(event.data()??{});
      emit(GetCarModelSuccess());
    });
  }

  void changeFav({required bool isFav, required String id}) {
    FirebaseFirestore.instance
        .collection('cars')
        .doc(id)
        .update({'isFav': !isFav}).then((value) {
      if (isFav) {
        emit(RemoveCarFromFavSuccess());
      } else {
        emit(AddCarToFavSuccess());
      }
    });
  }
}
