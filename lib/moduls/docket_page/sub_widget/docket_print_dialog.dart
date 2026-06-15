import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";
import "package:toggle_switch/toggle_switch.dart";

import "../../../utils/pref.dart";
import "../../../utils/tms_color.dart";
import "../../../widgets/tms_button.dart";

DocketDialog() {
  Get.defaultDialog(
      barrierDismissible: false,
      buttonColor: AppColor.blue,
      confirm: TmsButton(
          text: "OK",
          textSize: 10,
          onPressed: () {
            Get.back();
          }),
      radius: 10,
      middleText: "",
      title: "Print Settings",
      backgroundColor: Colors.white,
      titleStyle: const TextStyle(color: Colors.black),
      middleTextStyle: const TextStyle(color: Colors.black),
      content: Column(
        children: [
          ToggleSwitch(
            activeBgColor: [AppColor.blue],
            initialLabelIndex: Pref().getDocketPaketPrint() ? 1 : 0,
            totalSwitches: 2,
            labels: ['Docket', 'Paket'],
            onToggle: (index) {
              print('switched to: $index');
              if (Pref().getDocketPaketPrint()) {
                Pref().setDocketPaketPrint(value: false);
              } else {
                Pref().setDocketPaketPrint(value: true);
              }
            },
          ),
          // SizedBox(
          //   height: 10,
          // ),
          // ToggleSwitch(
          //   initialLabelIndex: Pref().getPrintType() ? 1 : 0,
          //   totalSwitches: 2,
          //   activeBgColor: [AppColor.blue],
          //   icons: [
          //     FontAwesomeIcons.qrcode,
          //     FontAwesomeIcons.barcode,
          //   ],
          //   onToggle: (index) {
          //     print('switched to: $index');
          //     if (Pref().getPrintType()) {
          //       Pref().setPrintType(value: false);
          //     } else {
          //       Pref().setPrintType(value: true);
          //     }
          //   },
          // ),
        ],
      ));
}
