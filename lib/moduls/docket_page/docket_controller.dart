// ignore_for_file: prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_classic/flutter_blue_classic.dart';
import 'package:get/get.dart';
import '../../model/dash_board_model/location_master.dart';
import '../../model/docket_model/docket.dart';
import '../../widgets/tms_button.dart';
import '../home_page/dash_board_controller.dart';

enum DataStatus { loading, completed, error }

enum PrinterEnum { gcn, quickDocket }

class DocketController extends GetxController {
  DashBoardController ctrl = Get.find<DashBoardController>();
  String docketNumbers = Get.arguments ?? '';
  MethodChannel channel = MethodChannel("tms.com/method");
  Rx<DataStatus> dataStatus = DataStatus.loading.obs;
  List<String> prnList = [];
  Rx<FlutterBlueClassic> flutterBlueClassicPlugin = FlutterBlueClassic(usesFineLocation: true).obs;

  ///DocketDetail List
  RxList<DocketInfo> docketData = <DocketInfo>[].obs;

  @override
  void onInit() {
    getDocketData(docketNumbers: docketNumbers);
    update();
    super.onInit();
  }

  Future<bool> checkBluetoothStatus(BuildContext context) async {
    bool isOn = await flutterBlueClassicPlugin.value.isEnabled;
    return isOn;
  }

  Future<void> showBluetoothDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            'Bluetooth turned off',
            style: TextStyle(),
          ),
          content: Text('Please enable Bluetooth to use this app.'),
          actions: <Widget>[
            TmsButton(
                text: "OK",
                onPressed: () {
                  Get.back();
                })
          ],
        );
      },
    );
  }

  /// list Store Docket Api data method

  Future<void> getDocketData({required String docketNumbers}) async {
    try {
      DocketDetail? docketDetail = await ctrl.docketApi(docketNumbers: docketNumbers);
      if (docketDetail!.data.isNotEmpty) {
        docketData(docketDetail.data);

        dataStatus(DataStatus.completed);
      } else {
        dataStatus(DataStatus.error);
      }
    } catch (err) {
      dataStatus(DataStatus.error);
    }
  }

  String getRglPrintData(argumentData, subIndex) {
    String pkgNo = "";
    if (subIndex.toString().length == 1) {
      pkgNo = "00" "${subIndex + 1}";
    } else if (subIndex.toString().length == 2) {
      pkgNo = "0" "${subIndex + 1}";
    } else if (subIndex.toString().length == 3) {
      pkgNo = "${subIndex + 1}";
    }
    return "SIZE 72.00 mm, 40 mm\n"
            "GAP 3 mm, 0 mm\n"
            "SET RIBBON OFF\n"
            "DIRECTION 0,0\n"
            "REFERENCE 0,0\n"
            "OFFSET 0 mm\n"
            "SET PEEL OFF\n" +
        "SET CUTTER OFF\n" +
        "SET PARTIAL_CUTTER OFF" +
        "SET TEAR ON\n" +
        "CLS\n" +
        "CODEPAGE 1252\n" +
        "BOX 55,12,505,305,2\n" +
        "TEXT 165,27,\"0\",0,8,8,\"RIGHT GEAR LOGISTICS\"\n" +
        "BARCODE 130,75,\"128M\",55,0,0,2,1,15,\"P${argumentData.dockno + pkgNo}\"\n" +
        "TEXT 75,154,\"0\",0,8,9,\"DOCKET NO : \"\n" +
        "TEXT 195,154,\"0\",0,8,9,\"${argumentData.dockno}\"\n" +
        "TEXT 75,192,\"0\",0,8,9,\"FROM : \"\n" +
        "TEXT 178,192,\"0\",0,8,9,\"${argumentData.orgncd} - ${shortenString(argumentData.csgnnm, 15)}\"\n" +
        "TEXT 75,230,\"0\",0,8,9,\"TO CITY : \"\n" +
        "TEXT 178,230,\"0\",0,8,9,\"${argumentData.toloc} - ${shortenString(argumentData.csgenm, 15)}\"\n" +
        "TEXT 75,275,\"0\",0,8,9,\"NO OF PKGS : \"\n" +
        "TEXT 200,275,\"0\",0,9,9,\"${subIndex + 1}/${argumentData.pkgsno.toInt()}\"\n" +
        "PRINT 1,1\n";
  }

  String shortenString(String input, int maxLength) {
    if (input.length <= maxLength) {
      return input;
    } else {
      return input.substring(0, maxLength - 2) + "..";
    }
  }

  Future<dynamic> printImageByMethodChannel({required Map<String, dynamic> arg}) async {
    await channel
        .invokeListMethod("launchZebra", arg)
        .then((value) => print(" heloooooooo" + value!.toList().toString() + " heloooooooo"));
  }

  location(String city) {
    if (ctrl.location.isNotEmpty) {
      List<LocationList> locationList = ctrl.location;
      LocationList selectedValue =
          locationList.where((innerValue) => innerValue.locCode.contains(city)).first;

      String cityFullName = selectedValue.locName;

      return cityFullName;
    } else {
      return city;
    }
  }
}
