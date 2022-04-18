import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/shared/helper/bloc_observer.dart'; 
import 'package:platinum_app/screens/splash_screen/splash_screen.dart';
import 'package:platinum_app/shared/services/local/cache_helper.dart';
import 'package:platinum_app/shared/styles/styles.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      CachedHelper.init();
      Firebase.initializeApp();
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Platinum App',
      theme: ThemeManger.setLightTheme(),
      home: SplashScreen(),
    );
  }
}
