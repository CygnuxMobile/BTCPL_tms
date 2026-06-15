// import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../app_routes.dart';
import '../../model/manifest_model/manifest_credential.dart';
import '../../model/manifest_model/manifest_details.dart';
import '../../model/manifest_model/manifest_submit.dart';
import '../../model/manifest_model/prepare_manifest_success.dart';
import '../../utils/pref.dart';
import '../../utils/tmsapi_method.dart';
import '../../utils/tmsapp_api.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/manifest_widgets/custom_alertdialog.dart';
import '../../widgets/tost.dart';
import '../docket_page/docket_controller.dart';
import '../qr_page/qr_scan_ontroller.dart';

class ManifestController extends GetxController {
  RxList<Data> checkValidSerialNoDataList = <Data>[].obs;
  List<Bcserial> scanList = <Bcserial>[].obs;
  Rx<DataStatus> dataStatus = DataStatus.loading.obs;
  RxList<DocketManifest> docketManifest = <DocketManifest>[].obs;
  RxList<Serial> serial = <Serial>[].obs;
  FocusNode hideTextFocus = FocusNode();
  FocusNode scanFocusNode = FocusNode();

  // String datetime = ();
  late CheckValidSerialNoresponse checkValidSerialNoResponse;

  TextEditingController manifestScanController = TextEditingController();

  // final player = AudioPlayer();

  RxString toLocation = '${Pref().getNextLocation()}'.obs;

  // var abc = ctrl3.result!.code ?? 0;

  final Dio _dio = Dio();

  checkValidSerialNoPost(String code) async {
    AppLoader().show();
    var response = await WebService.tmsPostRequest(
      url: ApiService.checkValidSerialNo,
      body: checkValidSerialNoSendToJson(
        CheckValidSerialNoSend(
          brcd: Pref().getBaseLocation(),
          nextLocation: Pref().getNextLocation(),
          bcserialNo: code.trim(),
        ),
      ),
    );
    AppLoader().hide();
    tampScan = '';
    try {
      return checkValidSerialNoresponseFromJson(response.data);
    } catch (err) {
      manifestScanController.clear();
      print(err);
      return null;
    }
  }

  Future<void> checkValidSerialData(context, String code) async {
    try {
      if (tampScan.isEmpty) {
        tampScan = code.trim();
        checkValidSerialNoResponse = (await checkValidSerialNoPost(code))!;
      }
      // await Pref.saveManifestDetails(val: JsonEncoder().convert(checkValidSerialNoresponse.toJson()));
      if (checkValidSerialNoResponse.data.dockno!.isNotEmpty) {
        checkValidSerialNoDataList.add(checkValidSerialNoResponse.data);
        dataStatus(DataStatus.completed);
        print('=-=-=-=-=-=-=-=-=-=-=-==-=$checkValidSerialNoDataList');
        print('=-=-=-=-=-=-=${checkValidSerialNoDataList[0].bcSerialNo}');
        ScanMode(context, code);
      } else {
        manifestScanController.clear();
        mfAlertDialog(
            context: context,
            title: 'Invalid',
            description: 'Wrong Scan Code.',
            cancelOnTap: () {
              Get.back();
            },
            onTap: () {
              Get.back();
            },
            onTapText: 'Ok');
      }
    } catch (err) {
      dataStatus(DataStatus.error);
    }
  }

  bool isScan = false;

  ScanMode(BuildContext context, String code) {
    Get.snackbar(
      "Scanned",
      "${code} no. scan successfully",
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 1),
      backgroundColor: Colors.green[300],
      colorText: Colors.white,
      borderRadius: 10.0,
      margin: EdgeInsets.all(10.0),
    );
    for (var checkValidSerialNoData in checkValidSerialNoDataList) {
      if (checkValidSerialNoData.bcserials!.isNotEmpty) {
        for (var bcSerialsList in checkValidSerialNoData.bcserials!) {
          bcSerialsList.isScanPkg = true;
        }
      }
    }
  }

  docketManifestAdd() {
    docketManifest.clear();
    serial.clear();
    for (int i = 0; i < checkValidSerialNoDataList.length; i++) {
      for (int k = 0; k < checkValidSerialNoDataList[i].bcserials!.length; k++) {
        if (checkValidSerialNoDataList[i].bcserials![k].isScanPkg == true) {
          serial.add(Serial(
              bcserialNo: checkValidSerialNoDataList[i].bcserials![k].bcSerialNo,
              docksf: checkValidSerialNoDataList[i].docksf!));
        }
      }

      double doc =
          ((checkValidSerialNoDataList[i].actuwt! / checkValidSerialNoDataList[i].totalPkg!));
      double weightLb = doc * serial.length;

      docketManifest.add(
        DocketManifest(
          dockno: checkValidSerialNoDataList[i].dockno!,
          docksf: checkValidSerialNoDataList[i].docksf!,
          packagesLb: serial.length,
          weightLb: weightLb.toInt(),
          orgCode: checkValidSerialNoDataList[i].orgCode!,
          reDestCode: checkValidSerialNoDataList[i].reDestCode!,
          docketDate: checkValidSerialNoDataList[i].docketDate!,
          pkgsno: checkValidSerialNoDataList[i].totalPkg!,
          actuwt: checkValidSerialNoDataList[i].actuwt!,
          newRate: 0,
          ratetype: '1',
        ),
      );
    }
    print('-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=');
    print('=====${docketManifest[0].dockno}');
    print('=====${docketManifest[0].docksf}');
    print('=====${docketManifest[0].packagesLb}');
    print('=====${docketManifest[0].weightLb}');
  }

  RxInt countScan(i) {
    int scanCount = 0;
    for (int j = 0; j < checkValidSerialNoDataList[i].bcserials!.length; j++) {
      if (checkValidSerialNoDataList[i].bcserials![j].isScanPkg == true) {
        scanCount++;
      }
    }
    return scanCount.obs;
  }

  String lastScanNo(i) {
    String lastScan = "";
    for (int j = 0; j < checkValidSerialNoDataList[i].bcserials!.length; j++) {
      if (checkValidSerialNoDataList[i].bcserials![j].isScanPkg == true) {
        lastScan = checkValidSerialNoDataList[i].bcserials![j].bcSerialNo;
      }
    }
    return lastScan;
  }

  String LocationName(value) {
    String locationName = value;
    String locationCode = locationName.split("-")[0].replaceAll(" ", "");

    return locationCode;
  }

  Future<PrepareManifest?> prepareManifestSubmit() async {
    AppLoader().show();
    final response = await _dio.post(
      ApiService.prepareManifest,
      data: prepareManifestToJson(
        PrepareManifest(
            baseLocationCode: Pref().getBaseLocation(),
            baseCompanyCode: Pref().getCompanyCode(),
            vehno: '',
            baseUserName: Pref().getUserName(),
            lsDate:
                '${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()).toString().replaceFirst(' ', 'T')}Z',
            baseFinYear: Pref().getFinYear().substring(0, 4),
            vehicleType: 'O',
            mFTransportMode: 'S',
            nextloc: Pref().getNextLocation(),
            docketManifests: docketManifest,
            serials: serial),
      ),
      options: Options(
          method: 'POST',
          headers: {"Content-Type": "application/json"},
          responseType: ResponseType.plain),
    );
    print("-------${response.data}");
    AppLoader().hide();
    try {
      prepareManifestResponseFromJson(response.data);
      if (response.statusCode == 200) {
        PrepareManifestResponse prepareManifestSubmit =
            prepareManifestResponseFromJson(response.data);

        checkValidSerialNoDataList.clear();
        TmsToast.msg(prepareManifestSubmit.message);
        Get.offAndToNamed(AppRoutes.dashboardScreen);
      } else {
        TmsToast.msg('Something is worn');
      }
    } catch (err) {
      print(err);
      return null;
    }
    return null;
  }

  void checkScanResult(BuildContext context, String code) {
    int showOne = 0;
    int one = 0;
    bool isSerial = false, isScanPkg = false;
    if (checkValidSerialNoDataList.isNotEmpty) {
      for (var tapCheckValidSerialNoDataList in checkValidSerialNoDataList) {
        if (tapCheckValidSerialNoDataList.bcserials!.isNotEmpty) {
          for (var data in tapCheckValidSerialNoDataList.bcserials!) {
            if (code.trim() == data.bcSerialNo) {
              isSerial = true;
              bool allScan = tapCheckValidSerialNoDataList.bcserials!
                  .every((element) => element.isScanPkg == true);
              if (!allScan) {
                if (Pref().getMfScan() == true) {
                  tapCheckValidSerialNoDataList.bcserials!
                      .every((element) => element.isScanPkg = true);
                  isSerial = true;
                  showOne++;
                  checkValidSerialNoDataList.refresh();
                  if (showOne <= 1) {
                    manifestScanController.clear();
                    Get.snackbar(
                      "$code",
                      "Scan successfully",
                      snackPosition: SnackPosition.TOP,
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.green[300],
                      colorText: Colors.white,
                      borderRadius: 10.0,
                      margin: EdgeInsets.all(10.0),
                    );
                  }
                } else {
                  isSerial = true;
                  if (data.isScanPkg == false) {
                    data.isScanPkg = true;
                    manifestScanController.clear();
                    Get.snackbar(
                      "$code",
                      "Scan successfully",
                      snackPosition: SnackPosition.TOP,
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.green[300],
                      colorText: Colors.white,
                      borderRadius: 10.0,
                      margin: EdgeInsets.all(10.0),
                    );

                    checkValidSerialNoDataList.refresh();
                  } else {
                    isScanPkg = true;
                    manifestScanController.clear();
                  }
                }
              } else {
                isScanPkg = true;
                one++;
                if (one == 1) {
                  manifestScanController.clear();
                  Get.snackbar(
                    "Scanned",
                    "Already scan this number",
                    snackPosition: SnackPosition.TOP,
                    duration: Duration(seconds: 1),
                    backgroundColor: Colors.red[300],
                    colorText: Colors.white,
                    borderRadius: 10.0,
                    margin: EdgeInsets.all(10.0),
                  );
                }
              }
            }
          }
        }
      }
      if (!isSerial) {
        checkValidSerialData(context, code);
      }

      if (isScanPkg) {
        manifestScanController.clear();
        Get.snackbar(
          "Scanned",
          "Already scan this number",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red[300],
          colorText: Colors.white,
          borderRadius: 10.0,
          margin: EdgeInsets.all(10.0),
        );
      }
    } else {
      checkValidSerialData(context, code);
    }
  }
}
