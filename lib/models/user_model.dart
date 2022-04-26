import 'package:platinum_app/shared/helper/mangers/constants.dart';

class UserModel {
  String? username;
  String? email;
  String? password;
  String ? image;
  String? uid;

  UserModel(
      {required this.username,
      required this.email,
      required this.password,
      required this.uid,
        this.image= ConstantsManger.DEFAULT,
      });

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
    uid = json['uid'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'uid': uid,
      'image':image,
    };
  }
}
