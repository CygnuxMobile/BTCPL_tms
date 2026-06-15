import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../main.dart';
import '../../model/pod_models/getpod_req.dart';
import '../../model/pod_models/getpod_res.dart';
import '../../utils/podDb/poddb_handler.dart';
import '../../utils/pref.dart';
import '../../utils/tmsapi_method.dart';
import '../../utils/tmsapp_api.dart';

enum ApiStatus { none, loading, success, error }

class PodUploadController extends GetxController {
  TextEditingController gcNumberController = TextEditingController();
  TextEditingController lrNumberController = TextEditingController();
  Rx<TextEditingController> formDate = TextEditingController(
    text: DateFormat('d MMM yyyy').format(DateTime.now().subtract(const Duration(days: 30))),
  ).obs;
  Rx<TextEditingController> toDate =
      TextEditingController(text: DateFormat('d MMM yyyy').format(DateTime.now()).toString()).obs;

  RxBool isOnline = false.obs;
  final RxBool isOfflineView = false.obs;

  Rx<ApiStatus> podListApiStatus = ApiStatus.none.obs;

  RxList<Docket> podList = <Docket>[].obs;
  RxList<Pod> podApiList = <Pod>[].obs;

  RxInt selectedTab = 0.obs;
  var searchQuery = ''.obs;

  void podListApi() async {
    podListApiStatus.value = ApiStatus.loading;
    try {
      final response = await WebService.tmsPostRequest(
          url: ApiService.getPodList,
          body: getPodListReqToJson(GetPodListReq(
              brcd: Pref().getBaseLocation(),
              userName: Pref().getUserName(),
              companyCode: Pref().getCompanyCode(),
              fromDate: formDate.value.text,
              toDate: toDate.value.text,
              gcNo: lrNumberController.text)));

      ///CNNDLS2526002359
      final data = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (data["data"] != null) {
          podListApiStatus.value = ApiStatus.success;
          PodListResponse podListResponse = podListResponseFromJson(response.data);
          podApiList.value = podListResponse.data.pod;
          dbDataInsert(podApiList);
          podList.value = podDb.getAllDocket();
        } else {
          podListApiStatus.value = ApiStatus.error;
        }
      } else {
        podListApiStatus.value = ApiStatus.error;
      }
    } catch (error) {
      podListApiStatus.value = ApiStatus.error;
    }
  }

  void dbDataInsert(List<Pod> podList) {
    print("🤷‍♂️ Total docket inserted: ${podList.length}");
    final existingDockets = podDb.getAllDocket();

    final existingDockNos = existingDockets.map((e) => e.dockNo).toSet();
    final apiDockNos = podList.map((e) => e.dockno).toSet();

    if (existingDockets.isEmpty) {
      for (var pod in podList) {
        podDb.insertDocket(
          Docket(
            dockNo: pod.dockno,
            dockDt: pod.dockdt,
            tripSheetNo: pod.tripSheetNo,
            podImagePaths: pod.podImagePaths,
            buttonName: pod.buttonName.value,
            status: pod.status.value,
            apiStatusIndex: 0,
            loading: false,
          ),
        );
      }
      print("✅ First-time insert: All ${podList.length} dockets added.");
    } else {
      final removedDockNos = existingDockNos.difference(apiDockNos);
      for (var dockNo in removedDockNos) {
        final toRemove = existingDockets.firstWhere((e) => e.dockNo == dockNo);
        podDb.deleteDocket(toRemove.id);
        print("❌ Removed outdated docket: $dockNo");
      }

      for (var pod in podList) {
        if (!existingDockNos.contains(pod.dockno)) {
          podDb.insertDocket(
            Docket(
              dockNo: pod.dockno,
              dockDt: pod.dockdt,
              tripSheetNo: pod.tripSheetNo,
              podImagePaths: pod.podImagePaths,
              buttonName: pod.buttonName.value,
              status: pod.status.value,
              apiStatusIndex: 0,
              loading: false,
            ),
          );
          print("✅ New docket inserted: ${pod.dockno}");
        } else {
          print("⚠️ Duplicate dockNo skipped: ${pod.dockno}");
        }
      }
    }
  }

  submitHandel({
    required bool isOnline,
    required String docketNo,
    required String podImage,
    required String podImageBack,
  }) {
    if (isOnline) {
      podSubmit(
        docketNo: docketNo,
        podImage: podImage,
        podImageBack: podImageBack,
      );
    } else {
      podDb.podUploadStatus(status: 1, dockNo: docketNo);
      podList.value = podDb.getAllDocket();
      Get.snackbar(
        'Success',
        'POD for ${docketNo} saved offline successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  podSubmit({
    required String docketNo,
    required String podImage,
    required String podImageBack,
  }) async {
    final matchIndex = podList.indexWhere((pod) => pod.dockNo == docketNo);
    if (matchIndex == -1) {
      print("❌ No matching docket found for $docketNo");
      return;
    }

    podList[matchIndex].loading = true;
    podList.refresh();

    final response = await WebService.multiPartRequest(
      url: ApiService.uploadPODImage,
      podImage: podImage,
      podImageBack: podImageBack,
    );

    podList[matchIndex].loading = false;
    podList.refresh();

    if (response.statusCode == 200) {
      Get.snackbar(
        'Success',
        'POD for ${podList[matchIndex].dockNo} uploaded successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      podDb.removeDocket(dockNo: podList[matchIndex].dockNo);
      podList.value = podDb.getAllDocket();

      print("✅ Success: ${response.statusCode}");
    } else {
      print("⚠️ Failed: ${response.statusCode}");
    }
  }

  Future<void> uploadPendingPODs() async {
    final pendingList = podList.where((docket) => docket.apiStatusIndex == 1).toList();

    for (var docket in pendingList) {
      final index = podList.indexWhere((p) => p.dockNo == docket.dockNo);

      if (index != -1) {
        print("📦 Uploading Docket No = ${docket.dockNo}");

        podList[index].loading = true;
        podList.refresh();

        await podSubmit(
          docketNo: podList[index].dockNo,
          podImage: podList[index].podImagePaths.isNotEmpty ? podList[index].podImagePaths[0] : "",
          podImageBack:
              podList[index].podImagePaths.length > 1 ? podList[index].podImagePaths[1] : "",
        );
      } else {
        print("⚠️ Docket not found in podList for dockNo: ${docket.dockNo}");
      }
    }
  }
}
