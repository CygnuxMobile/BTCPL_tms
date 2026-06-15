import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:intl/intl.dart';
import '../../app_routes.dart';
import '../../model/drs_model/drs_submit/drs_submit_request.dart';
import '../../model/drs_model/drs_submit/drs_submit_response.dart';
import '../../model/drs_model/drs_update_details/drs_update_details_request.dart';
import '../../model/drs_model/drs_update_details/drs_update_details_response.dart';
import '../../model/drs_model/drs_update_list/drs_update_list_request.dart';
import '../../model/drs_model/drs_update_list/drs_update_list_response.dart';
import '../../model/drs_model/general_master_response.dart';
import '../../utils/date_format.dart';
import '../../utils/pref.dart';
import '../../utils/tmsapi_method.dart';
import '../../utils/tmsapp_api.dart';
import '../../widgets/dashboard_widgets/custom_drawer.dart';
import '../../widgets/submit_alert_dialog.dart';
import '../../widgets/tost.dart';
import '../home_page/dash_board_screen.dart';

enum DataStatus { loading, done, error }

class DRSController extends GetxController {
  TextEditingController drsFromDateCtl = TextEditingController(
      text: DateFormat("dd MMM yyyy").format(DateTime.now().subtract(const Duration(days: 12))));
  TextEditingController drsToDateCtl =
      TextEditingController(text: DateFormat("dd MMM yyyy").format(DateTime.now()));
  TextEditingController deliveredPkgsController = TextEditingController();
  TextEditingController drsRemarkController = TextEditingController();
  TextEditingController closeKmController = TextEditingController();
  TextEditingController drsScanController = TextEditingController();
  TextEditingController drsUpdateScanController = TextEditingController();

  late DrsDetailData drsDetailData;

  List<DrsList> drsList = <DrsList>[];
  List<DrsDetailList> drsDetailList = <DrsDetailList>[];
  List<GeneralMasterList> remarkList = <GeneralMasterList>[];
  List<GeneralMasterList> qtyMissRemarkList = <GeneralMasterList>[];

  Rx<DataStatus> drsListDataStatus = DataStatus.loading.obs;
  Rx<DataStatus> docketListDataStatus = DataStatus.loading.obs;

  RxBool isShow = false.obs;
  RxInt enteredValue = 0.obs;
  String? reason;
  String? qtyReason;
  String? tapDrsNo;

  /// DrsList api
  Future<void> drsListApi({
    required BuildContext context,
  }) async {
    try {
      var response = await WebService.tmsPostRequest(
        url: ApiService.dRSUpdateList,
        body: drsUpdateListRequestToJson(
          DrsUpdateListRequest(
              baseLocationCode: Pref().getBaseLocation(),
              dateFrom: drsFromDateCtl.text,
              dateTo: drsToDateCtl.text,
              baseCompanyCode: Pref().getCompanyCode(),
              userId: Pref().getUserId()),
        ),
      );

      if (response.statusCode == 200) {
        DrsUpdateListResponse drsUpdateListResponse =
            await drsUpdateListResponseFromJson(response.data);
        if (drsUpdateListResponse.status == 200) {
          drsList = drsUpdateListResponse.data.drsLists;
          drsListDataStatus.value = DataStatus.done;
          // dashBordMenuEnum = DashBordMenuEnum.drsUpdate;
          TmsToast.msg(drsUpdateListResponse.message);
          drsRemark();
        } else {
          TmsToast.msg(drsUpdateListResponse.message);
          drsListDataStatus.value = DataStatus.error;
        }
      } else {
        TmsToast.msg(response.statusMessage!);
        drsListDataStatus.value = DataStatus.error;
      }
    } catch (error) {
      TmsToast.msg('Get drs List -$error');
      drsListDataStatus.value = DataStatus.error;
    }
  }

  /// Change api format
  String showDate(String date) {
    if (date.isNotEmpty) {
      String dateString = date;
      DateFormat inputFormat = DateFormat(DateAndTimeFormat.yyyyMMddTHHmmSS);
      DateTime dateTime = inputFormat.parse(dateString);
      DateFormat outputFormat = DateFormat(DateAndTimeFormat.yyyyMMdd);
      String formattedDate = outputFormat.format(dateTime);
      return formattedDate;
    } else {
      return '';
    }
  }

  /// Drs List Scan and check right and wrong
  void drsListScan(context, String qrScanNumber, bool isQr) {
    bool isScanTrue = drsList.any((element) => element.pdcno == qrScanNumber);
    if (isScanTrue) {
      if (isQr) {
        Get.back();
      }
      updateDrsApi(
        context: context,
        drsId: qrScanNumber,
      );
      dashBordMenuEnum = DashBordMenuEnum.drsUpdate;
    } else {
      TmsToast.msg('Please Scan Right Qrcode');
    }
  }

  deliveredPkgsValidation(newValue, index) {
    if (newValue.isNotEmpty) {
      enteredValue.value = int.parse(newValue);
      if (enteredValue.value < 0) {
        deliveredPkgsController.text = '0';
      } else if (enteredValue.value >= drsDetailList[index].pkgsArrived) {
        deliveredPkgsController.text = "${drsDetailList[index].pkgsArrived}";
        isShow.value = false;
      } else {
        enteredValue.value = int.parse(newValue);
        if (enteredValue.value <= drsDetailList[index].pkgsArrived) {
          isShow.value = true;
        } else {
          isShow.value = false;
        }
      }
    }
  }

  /// Drs update Api
  Future<void> updateDrsApi({
    required BuildContext context,
    required String drsId,
  }) async {
    var response = await WebService.tmsPostRequest(
      url: ApiService.updateDRSDetails,
      body: drsUpdateDetailsRequestToJson(
        DrsUpdateDetailsRequest(
          drsId: drsId,
          baseLocationCode: '${Pref().getBaseLocation()}',
        ),
      ),
    );
    try {
      if (response.statusCode == 200) {
        DrsUpdateDetailsResponse drsUpdateDetailsResponse =
            drsUpdateDetailsResponseFromJson(response.data);
        if (drsUpdateDetailsResponse.statusCode == 200) {
          drsDetailData = drsUpdateDetailsResponse.drsDetailData;
          drsDetailList = drsDetailData.drsDetailList;
          docketListDataStatus.value = DataStatus.done;
          closeKmController.text = (drsDetailData.startKm + 5).toString();
          TmsToast.msg(drsUpdateDetailsResponse.message);

          if (drsDetailList.isEmpty) {
            Get.offNamed(AppRoutes.drsListScreen);
            drsListDataStatus.value = DataStatus.loading;
            drsListApi(context: context);
          }
        } else {
          docketListDataStatus.value = DataStatus.error;
          TmsToast.msg(drsUpdateDetailsResponse.message);
        }
      } else {
        docketListDataStatus.value = DataStatus.error;
        TmsToast.msg(response.statusMessage!);
      }
    } catch (error) {
      if (response.data == null) {
        TmsToast.msg('No data Found');
      } else {
        docketListDataStatus.value = DataStatus.error;
        TmsToast.msg(error.toString());
      }
    }
  }

  /// drs update screen scan
  void drsUpdateScan(context, String qrScanNumber, bool isQr) {
    bool isScanTrue = drsDetailList.any((element) => element.dockno == qrScanNumber);
    int index = drsDetailList.indexWhere((element) => element.dockno == qrScanNumber);
    if (isScanTrue) {
      if (isQr) {
        Get.back();
      }
      Get.toNamed(
        AppRoutes.drsUpdateScreen,
        arguments: index,
      );
    } else {
      TmsToast.msg('Please Scan Right Qrcode');
    }
  }

  /// Modify the drsRemark method to accept a list of code types
  Future<void> drsRemark() async {
    String baseUrl = "${ApiService.baseUrl}V1/Master/GetGeneralMasterData";
    final List<String> codeTypes = ["LATE_D", "UNDELY"];

    for (String codeType in codeTypes) {
      String url = "$baseUrl?CodeType=$codeType";

      try {
        final dio.Response response = await WebService.tmsGetRequest(url);
        if (response.statusCode == 200) {
          GeneralMasterResponse generalMasterResponse =
              generalMasterResponseFromJson(response.data);
          if (codeType == 'LATE_D') {
            remarkList = generalMasterResponse.generalMasterList;
          } else {
            qtyMissRemarkList = generalMasterResponse.generalMasterList;
          }
        } else {
          print(response.statusMessage);
        }
      } catch (error) {
        if (kDebugMode) {
          print(error.reactive);
        }
      }
    }
  }

  ///drs submit request
  DrsSubmitRequest drsSubmitReq(int index) {
    tapDrsNo = drsDetailData.pdcno;
    return DrsSubmitRequest(
      drsSummary: DrsSummary(
        pdcno: drsDetailData.pdcno,
        pdCDt: drsDetailData.pdCDt,
        deliveryBy: drsDetailData.deliveryBy,
        driverName: drsDetailData.driverName,
        totalDocketsInDrs: drsDetailData.totalDocketsInDrs,
        closeKm: int.parse(closeKmController.text),
        toDate: DateAndTimeFormat().formattedDate,
        fromDate: DateAndTimeFormat().formattedDate,
        loadingCharge: 0,
        dockno: '',
        actuwt: 0,
        autoNo: 0,
        bAVendorCode: '',
        dockdt: DateAndTimeFormat().formattedDate,
        drs: '',
        drsDate: DateAndTimeFormat().formattedDate,
        drSDt: '',
        drsNoList: '',
        hdnRate: 0,
        isMathadi: false,
        isMonthly: true,
        loadingBy: '',
        mathadiAmt: 0,
        mathadiDate: DateAndTimeFormat().formattedDate,
        mathadiSlipNo: '',
        maxLimit: 0,
        pdCUpdated: '',
        pkgsno: 0,
        rate: 0,
        rateType: '',
        staff: '',
        startKm: 0,
        vehno: '',
        vendorCode: '',
        vendorName: '',
      ),
      updateDrsLits: [
        UpdateDrsLit(
          autoNo: drsDetailList[index].autoNo,
          dockno: drsDetailList[index].dockno,
          bookingDate: drsDetailList[index].bookingDate,
          orgncd: drsDetailList[index].orgncd,
          destcd: drsDetailList[index].destcd,
          payBasis: drsDetailList[index].payBasis,
          csgecd: drsDetailList[index].csgecd,
          csgenm: drsDetailList[index].csgenm,
          csgncd: drsDetailList[index].csgncd,
          csgnnm: drsDetailList[index].csgnnm,
          pkgsArrived: drsDetailList[index].pkgsArrived,
          pkgsBooked: drsDetailList[index].pkgsBooked,
          pkgsPending: drsDetailList[index].pkgsPending,
          wtArrived: drsDetailList[index].wtArrived,
          commDelyDt: drsDetailList[index].commDelyDt,
          delydate: DateAndTimeFormat().formattedDate,
          delytime: DateAndTimeFormat().formattedDate,
          delyperson: Pref().getUserName(),
          pkgsdelivered: int.parse(deliveredPkgsController.text),
          remark: drsRemarkController.text,
          hDcboReason: reason!,
          cboLateReason: isShow.isTrue ? qtyReason! : '',
          rate: 0,
          maxLimit: 0,
          docksf: drsDetailList[index].docksf,
          actQty: 0,
          bookedWt: 0,
          cboReason: '',
          cdeldTDdmmyyyy: '',
          coDDod: '',
          coddod: true,
          coddodAmount: 0,
          coddodcollected: 0,
          coddodno: 0,
          currLoc: '',
          delyLocation: '',
          dlypdcno: '',
          dockDt: DateAndTimeFormat().formattedDate,
          dockDtDdmmyyyy: drsDetailList[index].dockDtDdmmyyyy,
          docketTotal: 0,
          freight: 0,
          isChecked: true,
          isEnabled: true,
          isEnabledBadPodoption: true,
          newRate: 0,
          otp: '',
          payBasCode: '',
          pkgQty: 0,
          ratetype: '',
          backPOD: "",
          frontPOD: "",
          serviceTax: 0,
        ),
      ],
      loadingCharge: 0,
      baseUserName: Pref().getUserName(),
    );
  }

  ///Drs Submit api
  Future<void> drsSubmitApi({
    required BuildContext context,
    required int index,
  }) async {
    drsSubmitRequestToJson(drsSubmitReq(index));
    appLoader.show();
    var response = await WebService.tmsPostRequest(
      url: ApiService.updateDRS,
      body: drsSubmitRequestToJson(drsSubmitReq(index)),
    );
    try {
      appLoader.hide();
      if (response.statusCode == 200) {
        DrsSubmitResponse drsSubmitResponse = drsSubmitResponseFromJson(response.data);
        if (drsSubmitResponse.status == 200) {
          submitAlertDialog(
            context: context,
            title: 'Success',
            onTap: () {
              docketListDataStatus.value = DataStatus.loading;
              Get.toNamed(AppRoutes.docketListScreen);
              updateDrsApi(context: context, drsId: tapDrsNo!);
            },
            onTapText: 'Done',
            image: 'assets/images/dashboardimages/succes.png',
          );
        } else {
          TmsToast.msg(drsSubmitResponse.message);
        }
      } else {
        TmsToast.msg("Drs submit ${response.statusMessage!}");
      }
    } catch (error) {
      appLoader.hide();
      TmsToast.msg('Drs Submit error ${error.toString()}');
    }
  }
}
