import 'package:platinum_app/shared/helper/mangers/constants.dart';

class CarModel {
  String? id;
  String? sellerId;
  String? title;
  String? price;
  String? image;
  String? desc;
  bool? isFav;
  String? type;

  CarModel(
      {this.id = ConstantsManger.DEFAULT,
      required this.title,
      required this.price,
      required this.sellerId,
      required this.desc,
      required this.type,
      this.image = ConstantsManger.DEFAULT,
      required this.isFav});

  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    desc = json['desc'];
    isFav = json['isFav'];
    image = json['image'];
    type = json['type'];
    sellerId= json['sellerId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'desc': desc,
      'isFav': isFav,
      'image': image,
      'type': type,
      'sellerId':sellerId
    };
  }
}
