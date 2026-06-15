import 'package:btcpl/widgets/tms_button.dart';
import 'package:btcpl/widgets/tms_normaltext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

submitAlertDialog({
  required BuildContext context,
  required String title,
  required String image,
  required void Function() onTap,
  void Function()? printerTap,
  bool isPrintShow = false,
  required String onTapText,
}) {
  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        // insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        // clipBehavior: Clip.antiAliasWithSaveLayer,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Center(
            child: Text(
              title /*Create Manifest*/,
              style: TextStyle(
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 3,
              width: double.infinity,
              color: const Color(0xff03045E),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Image(
                image: AssetImage(image),
                height: 90,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TmsButton(
                    text: onTapText,
                    onPressed: onTap,
                  ),
                  if (isPrintShow) ...{
                    TmsButton(
                      text: "Print",
                      onPressed: printerTap ?? () {},
                    ),
                  },
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      );
    },
  );
}

TmsAlertDialog({
  required BuildContext context,
  String title = '',
  String description = '',
  required VoidCallback onPressed,
  required Size buttonSize,
  required String onTapText,
  required bool isShowImage,
}) {
  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              isShowImage ?
              Image(
                image: AssetImage(
                    "assets/images/dashboardimages/successdialog.png"),
                height: 60,
              ) : SizedBox(),
              if (title.isNotEmpty) ...{
                SizedBox(
                  height: 10,
                ),
                TmsText(
                  text: title,
                  fontSize: 15,
                  color: Color(0xff585858),
                  fontWeight: FontWeight.bold,
                ),
              },
              if (description.isNotEmpty) ...{
                SizedBox(
                  height: 05,
                ),
                TmsText(
                  text: description,
                  fontSize: 12,
                  color: Color(0xff8D8D8F),
                  fontWeight: FontWeight.w400,
                ),
              },
              SizedBox(
                height: 10,
              ),
              Button(
                text: onTapText,
                textSize: 13,
                size: buttonSize,
                onPressed: onPressed
              ),
            ],
          ),
        ),
      );
    },
  );
}
