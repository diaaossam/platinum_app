import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:platinum_app/models/car_model.dart';
import 'package:platinum_app/screens/main_layout/screens/home/home_screen.dart';
import 'package:platinum_app/screens/main_layout/screens/my_ads_screen/my_ads_screen.dart';
import 'package:platinum_app/screens/main_layout/screens/profile/profile_screen.dart';
import 'package:platinum_app/screens/main_layout/screens/sell_screen/sell_screen.dart';
import 'package:platinum_app/shared/helper/icon_broken.dart';
import 'package:platinum_app/shared/helper/mangers/constants.dart';
import '../screens/favorite_screen/fav_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(BuildContext context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> bottomListItem = [
    BottomNavigationBarItem(icon: Icon(IconBroken.User), label: 'Profile'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
    BottomNavigationBarItem(icon: Icon(IconBroken.Home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Sell Car'),
    BottomNavigationBarItem(
        icon: Icon(Icons.add_shopping_cart), label: 'My Ads'),
  ];
  List<Widget> screensList = [
    ProfileScreen(),
    FavoriteScreen(),
    HomeScreen(),
    SellCarScreen(),
    MyAdsScreen(),
  ];
  List<String> screenName = [
    'Profile',
    'Favorite',
    'Home',
    'Sell Car',
    'My Ads'
  ];

  int currentIndex = 2;

  void changeBottomNav(int index) {
    this.currentIndex = index;
    if (index == 1) {
      getFavCars();
    } else if (index == 4) {
      getMyAdsCars();
    }
    emit(ChangeBottomNavItemState());
  }

  void getSearchData({required String searchText}) {
    emit(OnGetSearchLoadingState());
  }
/////////////////////////////////////////////////////////
  String? categoryText;
  List<String> categoryList = [
    ConstantsManger.VAN,
    ConstantsManger.coupe,
    ConstantsManger.pick_up,
    ConstantsManger.motor,
    ConstantsManger.suv,
    ConstantsManger.sedan,
  ];

  void chooseCategory(String cat) {
    this.categoryText = cat;
    emit(ChooseCategoryState());
  }
///////////////////////////////////////////////
  String? fuelType;
  List<String> fuelList = [
    'Petrol','Diesel','Gasoline','Ethanol','Diesel Hybrid',
    'Bi-Fuel','Electric','Petrol Hybrid'
  ];

  void choosefuelType(String Fuelatype) {
    this.fuelType = Fuelatype;
    emit(ChooseFuelState());
  }


  ///////////////////////////////////////////////
  String? itemCon;
  List<String> itemConList = [
    'Used','New',
  ];

  void chooseItemCon(String ad) {
    this.itemCon = ad;
    emit(ChooseItemConState());
  }



  //////////////////////////////////////////////
  var picker = ImagePicker();
  List<XFile> productImages = [];

  Future getproductImages() async {
    final pickedFile = await picker.pickMultiImage();
    if (pickedFile != null) {
      productImages.addAll(pickedFile);
      emit(UploadProductImageSuccessState());
    } else {
      emit(UploadProductFailerState('No Image Selected'));
    }
  }

  void uploadCarInfo(
      {required CarModel carModel, required File vedioFile}) async {
    emit(UploadCarInfoLoading());
    await FirebaseFirestore.instance
        .collection("cars")
        .add(carModel.toMap())
        .then((value) {
      _uploadProductImage(id: value.id,vedioFile: vedioFile);
    });
  }

  List<String> imagesUrl = [];

  void _uploadProductImage(
      {required String id, required File vedioFile}) async {
    imagesUrl = [];
    for (int i = 0; i < productImages.length; i++) {
      await firebase_storage.FirebaseStorage.instance
          .ref("ProductImages")
          .child(id)
          .child("${Uri.file(productImages[i].path).pathSegments.last}")
          .putFile(File(productImages[i].path))
          .then((image) {
        image.ref.getDownloadURL().then((value) {
          imagesUrl.add(value);
        });
      });
    }
    await firebase_storage.FirebaseStorage.instance
        .ref("ProductVedios")
        .child(id)
        .putFile(vedioFile)
        .then((vedio) {
     vedio.ref.getDownloadURL().then((value)async{
       await FirebaseFirestore.instance
           .collection("cars")
           .doc(id)
           .update({'id': id, 'image': imagesUrl , 'video':value}).then((value) {
         emit(UploadCarInfoSuccess());
       });
      });
    });

  }

  List<CarModel> favCarList = [];

  void getFavCars() {
    emit(GetFavourtieCarsLoading());
    FirebaseFirestore.instance
        .collection("cars")
        .where('isFav', isEqualTo: true)
        .snapshots()
        .listen((event) {
      favCarList.clear();
      event.docs.forEach((cars) {
        favCarList.add(CarModel.fromJson(cars.data()));
      });
      emit(GetFavourtieCarsSuccess());
    });
  }

  void removeItemFromFav(String id) {
    FirebaseFirestore.instance
        .collection('cars')
        .doc(id)
        .update({'isFav': false}).then((value) {
      emit(RemoveCarFavourtie());
    });
  }

  List<CarModel> myCarsList = [];

  void getMyAdsCars() {
    emit(GetMyAdsCarsLoading());
    FirebaseFirestore.instance
        .collection("cars")
        .where('sellerId',
            isEqualTo: '${FirebaseAuth.instance.currentUser!.uid}')
        .snapshots()
        .listen((event) {
      myCarsList.clear();
      event.docs.forEach((cars) {
        myCarsList.add(CarModel.fromJson(cars.data()));
      });
      print(myCarsList.length);
      emit(GetMyAdsCarsSuccess());
    });
  }

  bool carTaxPaid = false;
   void setUpCarTaxPaid(){
     this.carTaxPaid= !carTaxPaid;
     emit(ChangeCheckBoxState());
   }
}
