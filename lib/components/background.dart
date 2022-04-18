import 'package:flutter/material.dart';

import '../shared/helper/mangers/size_config.dart';

class Background extends StatelessWidget {
  final Widget child;


  Background({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/main_top.png',
              width: SizeConfigManger.bodyHeight * 0.25,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset('assets/images/login_bottom.png',
              width: SizeConfigManger.bodyHeight * 0.35,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
