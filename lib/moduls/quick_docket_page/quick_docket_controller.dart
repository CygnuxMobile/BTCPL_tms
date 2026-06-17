import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../app_routes.dart';
import '../../model/dash_board_model/location_master.dart';
import '../../model/quick_docket_model/billing_response.dart';
import '../../model/quick_docket_model/check_valid_docket_no_response.dart';
import '../../model/quick_docket_model/city_api.dart';
import '../../model/quick_docket_model/custList_response.dart';
import '../../model/quick_docket_model/quick_docket_submit_models/quick_docket_request.dart';
import '../../model/quick_docket_model/quick_docket_submit_models/quick_docket_response.dart';
import '../../model/quick_docket_model/transit_mode_response.dart';
import '../../utils/date_format.dart';
import '../../utils/logging.dart';
import '../../utils/pref.dart';
import '../../utils/tmsapi_method.dart';
import '../../utils/tmsapp_api.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/submit_alert_dialog.dart';
import '../../widgets/tost.dart';

class QuickDocketController extends GetxController {
  final log = logger;

  List GeneralMasterTypeList = ["PAYTYP", "TRN"];

  RxList<BillingTypeList> pyaBasList = <BillingTypeList>[].obs;
  RxList<TransitMode> transitModeList = <TransitMode>[].obs;
  RxList<CustList> customerList = <CustList>[].obs;
  RxList<CustList> consignorConsigneeList = <CustList>[].obs;
  RxList<CityList> cityList = <CityList>[].obs;
  RxList<LocationList> location = <LocationList>[].obs;

  TextEditingController noOfPackageController = TextEditingController();
  TextEditingController consignorController = TextEditingController();
  TextEditingController consigneeController = TextEditingController();
  TextEditingController toCityController = TextEditingController();
  TextEditingController approxWeightController = TextEditingController();
  TextEditingController invoiceNoController = TextEditingController();
  TextEditingController docketNoController = TextEditingController();
  TextEditingController eWayBillNoController = TextEditingController();
  AppLoader appLoader = AppLoader();

  FocusNode noOfPkgsFocusNode = FocusNode();
  FocusNode approxWeightFocusNode = FocusNode();
  FocusNode invoiceNoFocusNode = FocusNode();

  String originLocation =
      Pref().getBranchCode() == 'HQTR' ? Pref().getBaseLocation() : Pref().getBranchCode();
  RxString billingType = ''.obs;
  String consignorId = '';
  String consignorName = '';
  String consigneeId = '';
  String consigneeName = '';
  String docketNm = "";
  String transitSelectId = "";
  String selectCity = "";
  int selectCityCode = 0;
  RxBool isFreeText = true.obs;

  ctrlClear() {
    noOfPackageController.clear();
    approxWeightController.clear();
    invoiceNoController.clear();
    docketNoController.clear();
    eWayBillNoController.clear();
  }

  void checkFiledValue({
    required BuildContext context,
    required GlobalKey<FormState> noOfPkgsFromKey,
    required GlobalKey<FormState> approxWeightFromKey,
    required GlobalKey<FormState> originLocationFromKey,
    required GlobalKey<FormState> cityFromKey,
    required GlobalKey<FormState> billingTypeFromKey,
    required GlobalKey<FormState> consignorFromKey,
    required GlobalKey<FormState> consigneeFromKey,
    required GlobalKey<FormState> invoiceNoFromKey,
    required GlobalKey<FormState> transitModeFromKey,
  }) {
    if (Pref().getBranchCode() == 'HQTR') {
      if (noOfPkgsFromKey.currentState!.validate() &&
          approxWeightFromKey.currentState!.validate() &&
          originLocationFromKey.currentState!.validate() &&
          cityFromKey.currentState!.validate() &&
          billingTypeFromKey.currentState!.validate() &&
          billingTypeFromKey.currentState!.validate() &&
          consignorFromKey.currentState!.validate() &&
          consigneeFromKey.currentState!.validate() &&
          invoiceNoFromKey.currentState!.validate()) {
        if (docketNoController.text.isEmpty) {
          quickDocketSubmitApi(context: context);
        } else {
          docketCheckApi(context: context);
        }
      }
    } else {
      if (noOfPkgsFromKey.currentState!.validate() &&
          approxWeightFromKey.currentState!.validate() &&
          cityFromKey.currentState!.validate() &&
          billingTypeFromKey.currentState!.validate() &&
          billingTypeFromKey.currentState!.validate() &&
          consignorFromKey.currentState!.validate() &&
          consigneeFromKey.currentState!.validate() &&
          invoiceNoFromKey.currentState!.validate()) {
        if (docketNoController.text.isEmpty) {
          quickDocketSubmitApi(context: context);
        } else {
          docketCheckApi(context: context);
        }
      }
    }
  }

  ///Billing Type
  Future<void> billingTypeApi({required BuildContext context}) async {
    context.loaderOverlay.show();
    String url = "${ApiService.baseUrl}V1/Master/GetGeneralMasterData?CodeType=PAYTYP";
    try {
      final dio.Response response = await WebService.tmsGetRequest(url);
      if (response.statusCode == 200) {
        log.i(jsonDecode(response.data), error: "Billing Type Api ${response.statusMessage}");
        BillingTypeResponse billingTypeResponse = billingTypeResponseFromJson(response.data);

        pyaBasList.value = billingTypeResponse.billingTypeList;
        Get.toNamed(AppRoutes.quickDocketScreen);
        context.loaderOverlay.hide();
      } else {
        context.loaderOverlay.hide();
        log.e(jsonDecode(response.data), error: "Billing Type Api ${response.statusMessage}");
        if (kDebugMode) {
          print(response.statusMessage);
        }
      }
    } catch (error) {
      context.loaderOverlay.hide();
      log.e(error, error: "Billing Type Api Error");
      if (kDebugMode) {
        print(error.reactive);
      }
    }
  }

  ///Transit Type
  Future<void> transitTypeApi({required BuildContext context}) async {
    String url = "${ApiService.baseUrl}V1/Master/GetGeneralMasterData?CodeType=TRN";
    try {
      final dio.Response response = await WebService.tmsGetRequest(url);
      if (response.statusCode == 200) {
        log.i(jsonDecode(response.data), error: "Transit Type Api ${response.statusMessage}");
        TransitModeResponse transitModeResponse = transitModeResponseFromJson(response.data);
        transitModeList.value = transitModeResponse.transitModeList;
        Get.toNamed(AppRoutes.quickDocketScreen);
        context.loaderOverlay.hide();
      } else {
        context.loaderOverlay.hide();
        log.e(jsonDecode(response.data), error: "Transit Type Api ${response.statusMessage}");
        if (kDebugMode) {
          print(response.statusMessage);
        }
      }
    } catch (error) {
      context.loaderOverlay.hide();
      log.e(error, error: "Transit Type Api Error");
      if (kDebugMode) {
        print(error.reactive);
      }
    }
  }

  Future<void> custListApi() async {
    appLoader.show();
    String url =
        "${ApiService.baseUrl}V1/Master/GetCustomerList?Search=%&Location=${Pref().getBaseLocation()}&Paybas=$billingType";
    print(url);
    final dio.Response response = await WebService.tmsGetRequest(url);
    appLoader.hide();
    try {
      if (response.statusCode == 200) {
        log.i(jsonDecode(response.data), error: "Customer List Api ${response.statusMessage}");

        CustListResponse custListResponse = custListResponseFromJson(response.data);

        customerList.value = custListResponse.custList;
      } else {
        customerList.clear();
        log.e(jsonDecode(response.data), error: "Customer List Api ${response.statusMessage}");
        TmsToast.msg('Docket check error ${response.statusMessage}');
        if (kDebugMode) {
          print(response.statusMessage);
        }
      }
    } catch (error) {
      customerList.clear();
      log.e(error, error: "Customer List Api Error");
      TmsToast.msg('No Data Found');
    }
  }

  Future<void> cityListApi() async {
    String url = "${ApiService.cityAPI}";
    print(url);
    try {
      final dio.Response response = await WebService.tmsPostTokenRequest(url: url, body: "");
      if (response.statusCode == 200) {
        log.i(jsonDecode(response.data), error: "City List Api ${response.statusMessage}");

        CityResponse cityResponse = cityResponseFromJson(response.data);

        cityList.value = cityResponse.data.cityList;
      } else {
        cityList.clear();
        log.e(jsonDecode(response.data), error: "City List Api ${response.statusMessage}");
        TmsToast.msg('Docket check error ${response.statusMessage}');
        if (kDebugMode) {
          print(response.statusMessage);
        }
      }
    } catch (error) {
      cityList.clear();
      log.e(error, error: "City List Api Error");
      TmsToast.msg('No Data Found');
    }
  }

  Future<void> getConsignorConsigneeList() async {
    String url = "${ApiService.baseUrl}V1/Master/GetCustList?Search=%%%";
    try {
      final dio.Response response = await WebService.tmsGetRequest(url);
      if (response.statusCode == 200) {
        log.i(jsonDecode(response.data),
            error: "Consignor Consignee List Api ${response.statusMessage}");
        CustListResponse custListResponse = custListResponseFromJson(response.data);
        consignorConsigneeList.value = custListResponse.custList;
      } else {
        consignorConsigneeList.clear();
        log.e(jsonDecode(response.data),
            error: "Consignor Consignee List Api ${response.statusMessage}");
      }
    } catch (error) {
      consignorConsigneeList.clear();
      log.e(error, error: "Consignor Consignee List Api Error");
    }
  }

  ///Quick Docket
  Future<void> docketCheckApi({required BuildContext context}) async {
    appLoader.show();
    String addUrl =
        '?DocketNo=${docketNoController.text}&LocCode=${Pref().getBaseLocation()}&UserId=${Pref().getUserName()}';
    //docketNoController.text
    var response = await WebService.tmsPostRequest(
      url: ApiService.checkValidDocketNo + addUrl,
      body: '',
    );
    appLoader.hide();
    try {
      if (response.statusCode == 200) {
        CheckValidDocketNoResponse checkValidDocketNoResponse =
            checkValidDocketNoResponseFromJson(response.data);

        if (checkValidDocketNoResponse.status == 200) {
          if (checkValidDocketNoResponse.data.codeId == '1') {
            quickDocketSubmitApi(context: context);
            log.i(jsonDecode(response.data),
                error: "Docket Check Api ${checkValidDocketNoResponse.message}");
            docketNoController.clear();
          } else {
            log.e(jsonDecode(response.data),
                error: "Docket Check Api ${checkValidDocketNoResponse.message}");
            docketNoController.clear();
            TmsToast.msg('Please Enter valid Docket Number');
          }
        } else {
          log.e(jsonDecode(response.data), error: "Docket Check Api ${response.statusMessage}");
          TmsToast.msg(checkValidDocketNoResponse.message);
          docketNoController.clear();
        }
      } else {
        log.i(jsonDecode(response.data), error: "Docket Check Api ${response.statusMessage}");
        TmsToast.msg("Docket no check - ${response.statusMessage}");
        docketNoController.clear();
      }
    } catch (error) {
      appLoader.hide();
      log.e(error, error: "Docket Check Api Error");
      TmsToast.msg('Docket check error ${error.toString()}');
      docketNoController.clear();
    }
  }

  Future<String> getLocationCode(String value) async {
    String locationName = value;
    String locationCode = locationName.split("-")[0].replaceAll(" ", '');
    return locationCode;
  }

  /// Billing Type
  billingSelectType(String value) {
    for (var data in pyaBasList) {
      if (data.codeDesc == value) {
        billingType.value = data.codeId;
      }
    }
  }

  /// Consignor Name
  consignorSelectName(String value) {
    try {
      consignorName = value;
      consignorId = consignorConsigneeList
          .firstWhere((innerValue) => innerValue.custnm == value)
          .custcd;
      consignorController.text = value;
    } catch (e) {
      log.e(e, error: "consignorSelectName Error");
    }
  }

  /// Consignee Name
  consigneeSelectName(String value) {
    try {
      consigneeName = value;
      consigneeId = consignorConsigneeList
          .firstWhere((innerValue) => innerValue.custnm == value)
          .custcd;
      consigneeController.text = value;
    } catch (e) {
      log.e(e, error: "consigneeSelectName Error");
    }
  }

  findTransitSelectId(String value) {
    transitSelectId =
        transitModeList.where((innerValue) => innerValue.codeDesc.contains(value)).first.codeId;
  }

  ///Quick Docket Submit Request
  quickDocketApiRequest() {
    QuickDocketSubmitRequest quickDocketSubmitRequest = QuickDocketSubmitRequest(
      dockdt: DateAndTimeFormat().dayMonthYear,
      partYCode: consignorId,
      partyName: consignorName,
      orgncd: "${Pref().getBaseLocation()}",
      destcd: Pref().getNextLocation(),
      paybas: billingType.value,
      currFinYear: Pref().getFinYear(),
      baseCompanyCode: Pref().getCompanyCode(),
      dockno: docketNoController.text,
      baseUserName: Pref().getUserName(),
      transPortModel: "2",
      pincode: "",
      toCity: toCityController.text.trim(),
      volYn: "N",
      csgncd: consignorId,
      csgnm: consignorName,
      csgnAdd: "",
      csgecd: consigneeId,
      csgenm: consigneeName,
      csgeAdd: "",
      fromCity: "",
      toPincode: "",
      pkgCode: "",
      docketInvoiceList: [
        DocketInvoice(
          invno: invoiceNoController.text,
          prodcd: "",
          pkgsty: "",
          pkgs: int.tryParse(noOfPackageController.text) ?? 0,
          decval: 0,
          actuwt: int.tryParse(approxWeightController.text) ?? 0,
          chrgwt: int.tryParse(approxWeightController.text) ?? 0,
          ewbno: eWayBillNoController.text,
          volL: 0,
          volB: 0,
          volH: 0,
          totCft: 0,
          eWayBillExpiredDate: DateTime.now().toIso8601String(),
          eWayBillInvoiceDate: DateTime.now().toIso8601String(),
          image: "",
        )
      ],
    );
    return quickDocketSubmitRequest;
  }

  ///Quick Docket
  Future<void> quickDocketSubmitApi({required BuildContext context}) async {
    quickDocketRequestToJson(quickDocketApiRequest());
    appLoader.show();
    var response = await WebService.tmsPostRequest(
      url: ApiService.quickDocketAPI,
      body: quickDocketRequestToJson(quickDocketApiRequest()),
    );
    appLoader.hide();
    try {
      if (response.statusCode == 200) {
        QuickDocketSubmitResponse quickDocketSubmitResponse =
            quickDocketSubmitResponseFromJson(response.data);
        if (quickDocketSubmitResponse.status == 200) {
          log.i(jsonDecode(response.data),
              error: "Quick Docket Submit Api ${quickDocketSubmitResponse.message}");
          docketNm = quickDocketSubmitResponse.data.docketno.isEmpty
              ? ''
              : quickDocketSubmitResponse.data.docketno;
          ctrlClear();
          submitAlertDialog(
            context: context,
            isPrintShow: true,
            title: '${docketNm} Docket number create successfully',
            onTap: () {
              Get.toNamed(AppRoutes.dashboardScreen);
              // Get.toNamed(AppRoutes.docketDetails, arguments: docketNm);
            },
            printerTap: () {
              Get.back();
              Get.toNamed(AppRoutes.docketDetails, arguments: docketNm);
            },
            onTapText: 'Done',
            icon: HugeIcons.strokeRoundedCheckmarkCircle01,
          );
        } else {
          log.e(jsonDecode(response.data),
              error: "Quick Docket Submit Api ${quickDocketSubmitResponse.message}");
          TmsToast.msg(quickDocketSubmitResponse.message);
        }
      } else {
        TmsToast.msg("Quick Docket submit ${response.statusMessage}");
      }
    } catch (error) {
      TmsToast.msg('Quick Docket Submit error ${error.toString()}');
    }
  }
}
