import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platinum_app/models/user_model.dart';
import 'package:platinum_app/shared/helper/mangers/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  late UserModel userModel;
  static ProfileCubit get(BuildContext context)=>BlocProvider.of(context);

  void getUserInfo() {
    emit(GetUserInfoLoading());
    FirebaseFirestore.instance
        .collection(ConstantsManger.USERS)
        .doc(_getCurrentUserUid())
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data() ?? {});
      emit(GetUserInfoSuccess());
    }).catchError((error) {
      emit(GetUserInfoFailure());
      print(error.toString());
    });
  }

  var _picker = ImagePicker();
  File? profileImage;

  Future getproductImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadImageToImage(profileImage);
    } else {
      print('No Image Selected');
    }
  }

  void uploadImageToImage(File? profileImage) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
        '${ConstantsManger.USERS}/profile/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection(ConstantsManger.USERS)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'image': value});
      });
      emit(ChangeUserImage());
    }).catchError((error) {
      print(error.toString());
    });
  }

  String _getCurrentUserUid()=>FirebaseAuth.instance.currentUser!.uid;
}
