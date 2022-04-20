import 'package:platinum_app/shared/helper/mangers/constants.dart';

class CarModel {
  String? id;
  String? sellerId;
  String? title;
  String? price;
  List<String> images = [];
  String? video;
  String? desc;
  bool? isFav;
  String? type;
  String ?  countryReg, enginePower, mileage, licenseExpire, color,year,
      fuelType, number, problems, itemCon;


  CarModel({
    this.id = ConstantsManger.DEFAULT,
    required this.title,
    required this.price,
    required this.sellerId,
    required this.desc,
    required this.type,
    required this.images,
    required this.video,
    required this.isFav,

    required this.countryReg,
    required this.enginePower,
    required this.mileage,
    required this.year,
    required this.licenseExpire,
    required this.color,
    required this.fuelType,
    required this.number,
    required this.problems,
    required this.itemCon,
  });

  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    desc = json['desc'];
    video = json['video'];
    isFav = json['isFav'];
    if (json['images'] != null) {
      json['images'].forEach((element) {
        images.add(element);
      });
    }
    type = json['type'];
    sellerId = json['sellerId'];

    year = json['year'];
    countryReg = json['countryReg'];
    enginePower = json['enginePower'];
    mileage = json['mileage'];
    licenseExpire = json['licenseExpire'];
    color = json['color'];
    fuelType = json['fuelType'];
    number = json['number'];
    problems = json['problems'];
    itemCon = json['itemCon'];

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
      'sellerId': sellerId,
      'video':video,
      'countryReg':countryReg,
      'enginePower':enginePower,
      'mileage':mileage,
      'licenseExpire':licenseExpire,
      'color':color,
      'fuelType':fuelType,
      'number':number,
      'problems':problems,
      'itemCon':itemCon,
      'year':year

    };
  }
}
