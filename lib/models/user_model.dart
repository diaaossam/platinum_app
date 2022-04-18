class UserModel {
  String? username;
  String? email;
  String? password;
  String? uid;

  UserModel(
      {required this.username,
      required this.email,
      required this.password,
      required this.uid,
      });

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
    uid = json['uid'];
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'uid': uid,
    };
  }
}
