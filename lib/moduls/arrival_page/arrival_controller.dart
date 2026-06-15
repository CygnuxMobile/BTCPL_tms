import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../model/arrival_model/arrival_credential.dart';
import '../../model/arrival_model/arrival_detail.dart';
import '../../model/arrival_model/arrival_submit/arrival_submit_request.dart';
import '../../utils/pref.dart';
import '../../utils/tmsapp_api.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/tost.dart';
import '../docket_page/docket_controller.dart';

class ArrivalController extends GetxController {
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController arrivalsFromDateCtl =
      TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 7))));
  TextEditingController arrivalsToDateCtl = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()); //ArrivalsTODAte
  TextEditingController closingKMCtrl = TextEditingController(); //ArrivalsTODAte
  TextEditingController incomingRemarkCtrl = TextEditingController(); //ArrivalsTODAte
  RxList<ThcData> thcArrivalsData = <ThcData>[].obs;

  int? closingKM;

  ///Submit arrival dropdown
  void onChangedValue(String val) => dropdownValue(val);
  Rx<String> dropdownValue = 'Ok'.obs;
  List<String> items = [
    'Ok',
    'Broken',
    'Unsealed',
  ];

  final Dio _dio = Dio();
  Rx<DataStatus> arrivalDataStatus = DataStatus.completed.obs;

  Future<ThcArrivalsListData?> thcArrivalsPost() async {
    try {
      final response = await _dio.post(
        ApiService.thcArrivalsList,
        data: thcArrivalsListToJson(
          ThcArrivalsList(
              thcNo: vehicleNumberController.text,
              fromDate: arrivalsFromDateCtl.text,
              transportMode: 'S',
              baseLocationCode: Pref().getBaseLocation(),
              toDate: arrivalsToDateCtl.text,
              baseComapnyCode: Pref().getCompanyCode(),
              baseusername: Pref().getUserName()),
        ),
        options: Options(method: 'POST', headers: {}, responseType: ResponseType.plain),
      );
      return thcArrivalsListDataFromJson(response.data);
    } catch (err) {
      print(err);
      return null;
    }
  }

  ///Get ThcArrival Data
  Future<void> getThcArrivalsData() async {
    arrivalDataStatus(DataStatus.loading);
    try {
      ThcArrivalsListData? thcArrivalsListData = await thcArrivalsPost();
      if (thcArrivalsListData != null) {
        thcArrivalsData(thcArrivalsListData.data);
        arrivalDataStatus(DataStatus.completed);
      } else {
        arrivalDataStatus(DataStatus.error);
      }
    } catch (err) {
      arrivalDataStatus(DataStatus.error);
    }
  }

  ///ThcArrival Submit Request
  ThcArrivalSubmitRequsetData(index) async {
    print('--------------${Pref().getBaseLocation()}');
    TmsLoader().show();
    final response = await _dio.post(
      ApiService.thcArrivalSubmit,
      data: thcArrivalSubmitRequestToJson(
        ThcArrivalSubmitRequest(
          thcno: thcArrivalsData[index].thcno,
          brcd: Pref().getBaseLocation(),
          ad: DateFormat.yMd().add_jms().format(DateTime.now()),
          at: DateFormat('hh:mm a').format(DateTime.now()),
          baseUserName: Pref().getUserName(),
          isn: 'dav',
          status: '$dropdownValue',
          closekm: closingKM!,
          ir: incomingRemarkCtrl.text,
          transportMode: thcArrivalsData[index].runCat,
          baseCompanyCode: thcArrivalsData[index].companyCode,
        ),
      ),
      options: Options(method: 'POST', headers: {"Content-Type": "application/json"}, responseType: ResponseType.plain),
    );
    print("-------${response.data}");
    TmsLoader().hide();
    try {
      if (response.statusCode == 200) {
        // PrepareManifestResponse prepareManifestSubmit = thcArrivalSubmitFromJson(response.data);
        TmsToast.msg('Success');
        //thcArrivalsData.removeWhere((element) => element == index);
        thcArrivalsData.removeAt(index);
        thcArrivalsData.refresh();
        update();
        Get.back();
      } else {
        TmsToast.msg('Something is worn');
        Get.back();
      }
    } catch (err) {
      print(err);
      return null;
    }
  }
}
