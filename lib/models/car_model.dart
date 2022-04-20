import 'package:platinum_app/shared/helper/mangers/constants.dart';

class CarModel {
  String? id;
  String? sellerId;
  String? title;
  String? price;
  List<String>  images= [];
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
      required this.images ,
      required this.isFav});

  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    desc = json['desc'];
    isFav = json['isFav'];
    if(json['images'] !=null){
      json['images'].forEach((element){
        images.add(element);
      });
    }
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
      'images': images,
      'type': type,
      'sellerId':sellerId
    };
  }
}
