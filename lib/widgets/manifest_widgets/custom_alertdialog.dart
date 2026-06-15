import 'package:flutter/material.dart';

import '../tms_button.dart';
import '../tms_normaltext.dart';

mfAlertDialog(
    {required BuildContext context,
    required String title,
    required String description,
    required void Function() cancelOnTap,
    required void Function() onTap,
    required String onTapText}) {
  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        // clipBehavior: Clip.antiAliasWithSaveLayer,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Center(
            child: Text(
              title /*Create Manifest*/,
              style: TextStyle(
                color: Color(0xff232F34),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 3,
              width: double.infinity,
              color: const Color(0xff646D72),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: TmsText(
                    fontSize: 13,
                    text:
                        description /*'Are you sure, do you want to Create Manifest ?'*/),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffE9ECEF),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(05)))),
                      onPressed: cancelOnTap,
                      child: TmsText(
                        text: 'Cancel',
                        color: Color(0xff232F34),
                        fontSize: 15,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  TmsButton(
                    text: onTapText,
                    onPressed: onTap,
                  ),
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

mflocAlertDialog(
    {required BuildContext context,
    required String title,
    required String description,
    required void Function() onTap,
    required String onTapText}) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(05))),

        ///394033
        // insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        // clipBehavior: Clip.antiAliasWithSaveLayer,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Center(
            child: Text(title /*Create Manifest*/),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 3,
              width: double.infinity,
              color: const Color(0xff646D72),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: TmsText(
                    text:
                        description /*'Are you sure, do you want to Create Manifest ?'*/),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  TmsButton(
                    text: onTapText,
                    onPressed: onTap,
                  ),
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
