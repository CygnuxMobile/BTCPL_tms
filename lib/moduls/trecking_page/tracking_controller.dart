import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../app_routes.dart';
import '../../model/trecking_model/tracking_request.dart';
import '../../model/trecking_model/tracking_response.dart';
import '../../utils/tmsapi_method.dart';
import '../../utils/tmsapp_api.dart';
import '../../widgets/tost.dart';
import '../home_page/dash_board_controller.dart';

class TrackingController extends GetxController {
  DashBoardController dashBoardController = Get.put(DashBoardController());
  List<GetTrackingDatum> getTrackingData = <GetTrackingDatum>[];

  late TreckingResponse treckingResponse;

  String docketNumber = "";
  String docketDate = "";
  String location = "";
  String billingParty = "";
  String consignee = "";
  String orgncd = "";
  String destcd = "";
  String podPath = "";
  String consignor = "";
  String noOfPkgs = "";
  String status = "";
  String Image = "";

  ///Tracking Api
  trackingApi(BuildContext context) async {
    context.loaderOverlay.show();
    final dio.Response response = await WebService.tmsPostRequest(
      url: ApiService.trackingDetails,
      body: treckingRequestToJson(
        TreckingRequest(docketNo: dashBoardController.trackingNumber.text),
      ),
    );
    try {
      context.loaderOverlay.hide();
      if (response.statusCode == 200) {
        treckingResponse = treckingResponseFromJson(response.data);
        if (treckingResponse.status == 200) {
          getTrackingData = treckingResponse.trackingData.getTrackingData;
          addValue();
          Get.toNamed(AppRoutes.treckingScreen);
          TmsToast.msg('Success');
        } else {
          TmsToast.msg(treckingResponse.message);
        }
      } else {
        TmsToast.msg("Tracking - ${response.statusMessage!}");
      }
    } catch (error) {
      TmsToast.msg("Tracking error - ${error.toString()}");
      // Tost.msg(error.toString());
    }
  }

  addValue() {
    docketNumber = treckingResponse.trackingData.docketno;
    docketDate = treckingResponse.trackingData.dockdt;
    location = treckingResponse.trackingData.originDest;
    billingParty = treckingResponse.trackingData.billingParty;
    consignee = treckingResponse.trackingData.cnee;
    consignor = treckingResponse.trackingData.cnor;
    noOfPkgs = treckingResponse.trackingData.pkgsno;
    orgncd = treckingResponse.trackingData.orgncd;
    destcd = treckingResponse.trackingData.destcd;
    Image =
        "https://bhorgroup.cygnux.in/Images/FMScanDocument/${treckingResponse.trackingData.podName}";
  }
}
