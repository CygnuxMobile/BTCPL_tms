import 'package:fluttertoast/fluttertoast.dart';


class TmsToast {


  static void msg(String msg) {

    Fluttertoast.showToast(msg: msg);
  }
}

