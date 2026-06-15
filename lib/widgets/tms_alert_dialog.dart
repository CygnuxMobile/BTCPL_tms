import 'package:flutter/material.dart';

TmsAlertDialog(
    BuildContext context, {
      required String? Sajesan,
      required VoidCallback? onpressed,
      required String? text,
      required bool? cancel,
      Function()? cancelonTap,
    }) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(22.0)),
        ),
        elevation: 0,
        content: Stack(
          alignment: Alignment.topRight,
          children: [
            cancel == true
                ? GestureDetector(
              onTap: cancelonTap,
              child: CircleAvatar(
                backgroundColor: Colors.black26,
                radius: 15,
                child: Icon(Icons.close, color: Colors.black, size: 20),
              ),
            )
                : const SizedBox(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 50),
                Text(
                  Sajesan!,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Divider(color: Colors.black),
                Container(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: onpressed,
                    child: Text(text!,style: TextStyle(color: Colors.white),),
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStatePropertyAll(Colors.blueGrey),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
