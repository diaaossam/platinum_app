import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/components/app_text.dart';
import 'package:platinum_app/screens/main_layout/cubit/main_cubit.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (context) => MainCubit()..getUserInfoProfile(),
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          MainCubit cubit = MainCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: AppText(text: cubit.screenName[cubit.currentIndex],isTitle: true,textSize: 26.0),
            ),
            body: cubit.screensList[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(

              items:cubit.bottomListItem,
              currentIndex: cubit.currentIndex,
              onTap: (int index)=>cubit.changeBottomNav(index),
            ),
            
          );
        },
      ),
    );
  }
}
