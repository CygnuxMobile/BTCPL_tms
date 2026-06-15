
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../app_routes.dart';
import '../../model/unloading_model/unloading_request.dart';
import '../../model/unloading_model/unloading_response.dart';
import '../../utils/tmsapp_api.dart';
import '../../widgets/tost.dart';
import '../home_page/dash_board_controller.dart';

class UnloadingScreenController extends GetxController {
  final Dio _dio = Dio();
  DashBoardController dashBoardController = Get.put(DashBoardController());
  late UnloadingResponse unloadingResponse;

  ///unloading sheet
  unloadingRequestData(BuildContext context) async {
    context.loaderOverlay.show();
    final response = await _dio.post(
      ApiService.getUnloadingSheetData,
      data: unloadingRequestToJson(
        UnloadingRequest(
          lodingSheetNo: dashBoardController.thcNumber.text,
        ),
      ),
      options: Options(
          method: 'POST',
          headers: {"Content-Type": "application/json"},
          responseType: ResponseType.plain),
    );
    try {
      if (response.statusCode == 200) {
        unloadingResponse = unloadingResponseFromJson(response.data);
        TmsToast.msg(unloadingResponse.message);
        Get.toNamed(AppRoutes.unloadingScreen);
        context.loaderOverlay.hide();
        update();
      } else {
        TmsToast.msg(response.statusMessage!);
        context.loaderOverlay.hide();
      }
    } catch (err) {
      TmsToast.msg(err.toString());
      context.loaderOverlay.hide();
      print(err);
      return null;
    }
  }
  ///Sum kg
  double getSumOfKg() {
    double sum = 0.0;
    for (var data in unloadingResponse.data.getLsNoData) {
      sum += double.parse(data.actuwt);
    }
    return sum;
  }

  ///Sum weight
  double getSumOfWeight() {
    double sum = 0.0;
    for (var data in unloadingResponse.data.getLsNoData) {
      sum += double.parse(data.nopkgs);
    }
    return sum;
  }
}
