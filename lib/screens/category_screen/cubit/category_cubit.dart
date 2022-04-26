import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:platinum_app/models/car_model.dart';
import 'package:platinum_app/shared/helper/mangers/colors.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  static CategoryCubit get(context) => BlocProvider.of(context);

  List<CarModel> carsList = [];

  void getCars(String type) {
    emit(GetCarsLoading());
    FirebaseFirestore.instance
        .collection("cars")
        .where('type', isEqualTo: type)
        .snapshots()
        .listen((event) {
      carsList.clear();
      event.docs.forEach((cars) {
        carsList.add(CarModel.fromJson(cars.data()));
      });
      print(carsList.length);
      emit(GetCarsSuccess());
    });
  }

  void getSearchData(String type, String text) {
    print('Daa');
    FirebaseFirestore.instance
        .collection("cars")
        .where('title', arrayContains: 'text')
        .get()
        .then((value) {
      value.docs.forEach((element) {});
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
