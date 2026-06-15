import 'package:btcpl/moduls/splash_page/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/app_size.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  SplashScreenController splashScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: Container(
                  width: AppSize.size(context).width / 2,
                  height: AppSize.size(context).height / 2,
                  child: Image.asset(
                    'assets/images/BTCPL-Digital-Logo-1.jpg',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
