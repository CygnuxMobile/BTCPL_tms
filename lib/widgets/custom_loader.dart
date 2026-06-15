import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum LoaderState { none, show, hide }

class AppLoader {
  void hide() {
    Get.back();
  }

  void show() {
    Get.defaultDialog(
      title: 'Please wait...',
      content: const CircularProgressIndicator(
        color:  Color(0xff232F34),
      ),
      middleText: "Please wait....",
      barrierDismissible: false,
    );
  }
}

class TmsLoader {
  void hide() {
    Get.back();
  }

  void show() {
    Get.defaultDialog(
      backgroundColor: Color(0xffFFFFFF),
      title: 'Please wait...',
      titleStyle: TextStyle(fontSize: 15),
      content: const CircularProgressIndicator(
        color: Color(0xff00CA75),
      ),
      middleText: "Please wait....",
      middleTextStyle: TextStyle(color:  Color(0xff232F34)),
      barrierDismissible: false,
    );
  }
}
