import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/models/car_model.dart';
import 'package:platinum_app/models/comeent_model.dart';
import 'package:platinum_app/screens/details/cubit/details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  CarModel? carModel;

  DetailsCubit() : super(InitialState());

  static DetailsCubit get(BuildContext context) => BlocProvider.of(context);

  void getCarDetails({required String id}) {
    emit(GetCarModelLoading());
    FirebaseFirestore.instance
        .collection('cars')
        .doc(id)
        .snapshots()
        .listen((event) {
      carModel = CarModel.fromJson(event.data() ?? {});
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

  IconData vedioIcon = Icons.play_arrow;

  changeIcon(bool isPlaying) {
    if (isPlaying) {
      vedioIcon = Icons.pause;
    } else {
      vedioIcon = Icons.play_arrow;
    }
    emit(ChangeVedioIcon());
  }

  void sendComment({required CommentModel commentModel}) {
    FirebaseFirestore.instance
        .collection('comments')
        .add(commentModel.toMap())
        .then((value) {
      print('ok');
    });
  }

  List<CommentModel> commentList = [];

  void getComments({required String carid}) {
    FirebaseFirestore.instance
        .collection('comments')
        .where('carId', isEqualTo: '${carid}')
        .snapshots()
        .listen((event) {
      commentList.clear();
      event.docs.forEach((element) {
        commentList.add(CommentModel.fromJson(element.data()));
      });
      emit(GetCCommentSuccess());
    });
  }
}
