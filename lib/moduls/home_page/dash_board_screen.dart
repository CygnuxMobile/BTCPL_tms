import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:location/location.dart';
import '../../app_routes.dart';
import '../../environments .dart';
import '../../utils/pref.dart';
import '../../widgets/app_size.dart';
import '../../widgets/custom_dropdown_search.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/dashboard_widgets/custom_box.dart';
import '../../widgets/dashboard_widgets/custom_drawer.dart';
import '../../widgets/tms_button.dart';
import '../../widgets/tms_normaltext.dart';
import '../../widgets/tost.dart';
import '../attendance_page/attendance_controller.dart';
import '../quick_docket_page/quick_docket_controller.dart';
import '../trecking_page/tracking_controller.dart';
import 'dash_board_controller.dart';

enum DashBordMenuEnum { manifest, stockUpdate, stockUpdateList, drsList, drsUpdate, none }

DashBordMenuEnum dashBordMenuEnum = DashBordMenuEnum.none;

enum WebViewEnum { manifest, thc, stockUpdate, arrival, none }

WebViewEnum webViewEnum = WebViewEnum.none;

class DashBordScreen extends StatefulWidget {
  const DashBordScreen({Key? key}) : super(key: key);

  @override
  State<DashBordScreen> createState() => _DashBordScreenState();
}

class _DashBordScreenState extends State<DashBordScreen> {
  DashBoardController ctrl = Get.put(DashBoardController());
  QuickDocketController quickDocketController = Get.put(QuickDocketController());
  AttendanceController attendanceController = Get.put(AttendanceController());
  TrackingController trackingController = Get.put(TrackingController());
  AppLoader appLoader = AppLoader();

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    final List<String> dashBordList = AppEnvironments.dashBordList;
    Location location = Location();

    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Colors.black.withOpacity(0.3),
      child: Scaffold(
        key: scaffoldKey,
        drawer: drawer(context),
        appBar: AppBar(
          title: TmsText(text: 'Dashboard', color: Colors.white),
          centerTitle: true,
          backgroundColor: Color(0xff232F34),
          leading: IconButton(
            icon: Icon(Icons.dehaze_outlined, color: Colors.white),
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                SizedBox(height: AppSize.size(context).height * 0.02),
                if (Pref().getBranchCode() == 'HQTR')
                  Obx(
                    () => Dropdown(
                      height: 25.0.obs,
                      image: "assets/images/dashboardimages/To.png".obs,
                      enabled: true.obs,
                      isSize: false,
                      boxDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFE9ECEF),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      text: Pref().getBaseLocation().isEmpty ? '  Select Location '.obs : '  ${Pref().getBaseLocation()}'.obs,
                      list: ctrl.location.map((element) => '${element.locCode} - ${element.locName}').toList(),
                      onChanged: (value) async {
                        await ctrl.getLocationCode(value!);
                      },
                    ),
                  )
                else
                  Dropdown(
                    height: 25.0.obs,
                    image: "assets/images/dashboardimages/To.png".obs,
                    enabled: Pref().getMultiLocation().isEmpty ? false.obs : true.obs,
                    isSize: false,
                    boxDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: const Color(0xFFE9ECEF),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    text: Pref().getBaseLocation().isEmpty ? '  Select Location '.obs : '  ${Pref().getBaseLocation()}'.obs,
                    list: Pref().getMultiLocation().map((e) => e.locName).toList(),
                    onChanged: (value) async {
                      for (var data in Pref().getMultiLocation()) {
                        if (data.locName == value!) {
                          await Pref().saveBaseLocation(val: data.locCode);
                        }
                      }
                    },
                  ),
                const SizedBox(height: 20),
                Flexible(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: [
                      for (var module in dashBordList)
                        if (module == 'quickDocket')
                          DashBoardContainer(
                            text: 'Quick Docket',
                            image: 'assets/images/dashboardimages/Delivery Boy.png',
                            ontap: () {
                              quickDocketController.billingTypeApi(context: context);
                            },
                          )
                        // else if (module == 'gcn')
                        //   DashBoardContainer(
                        //     text: 'GCN',
                        //     image: 'assets/images/dashboardimages/gcn.png',
                        //     ontap: () {
                        //       ctrl.docketNumber.clear();
                        //       customBottomSheet(context);
                        //     },
                        //   )
                        else if (module == 'manifest')
                          DashBoardContainer(
                            text: 'Manifest',
                            image: 'assets/images/dashboardimages/manifest.png',
                            ontap: () {
                              dashBordMenuEnum = DashBordMenuEnum.manifest;

                              Get.toNamed(AppRoutes.manifestScreen);
                            },
                          )
                        else if (module == 'manifestWithoutScening')
                          DashBoardContainer(
                            text: 'Manifest Without Scanning',
                            image: 'assets/images/dashboardimages/manifest.png',
                            ontap: () {
                              webViewEnum = WebViewEnum.manifest;
                              Get.toNamed(AppRoutes.webViewScreen);
                            },
                          )
                        else if (module == 'thcWithoutScening')
                          DashBoardContainer(
                            text: 'Thc',
                            image: 'assets/images/dashboardimages/thc.png',
                            ontap: () {
                              webViewEnum = WebViewEnum.thc;
                              Get.toNamed(AppRoutes.webViewScreen);
                            },
                          )
                        else if (module == 'arrivalWithoutScening')
                          DashBoardContainer(
                            text: 'Arrival Without Scanning',
                            image: 'assets/images/dashboardimages/arrived.png',
                            ontap: () {
                              webViewEnum = WebViewEnum.arrival;
                              Get.toNamed(AppRoutes.webViewScreen);
                            },
                          )
                        else if (module == 'arrival')
                          DashBoardContainer(
                            text: 'Arrival',
                            image: 'assets/images/dashboardimages/arrived.png',
                            ontap: () {
                              customBottomSheetArrival(context);
                            },
                          )
                        else if (module == 'stockUpdate')
                          DashBoardContainer(
                            text: 'Stock Update',
                            image: 'assets/images/dashboardimages/Stock Update.png',
                            ontap: () async {
                              dashBordMenuEnum = DashBordMenuEnum.stockUpdate;
                              String? baseLocation = Pref().getBaseLocation();
                              if (baseLocation.isEmpty) {
                                TmsToast.msg('Please add Location');
                              } else {
                                stockUpdateBottomSheetArrival(context);
                              }
                            },
                          )
                        else if (module == 'stockUpdateWithoutScening')
                          DashBoardContainer(
                            text: 'StockUpdate Without Scanning',
                            image: 'assets/images/dashboardimages/Stock Update.png',
                            ontap: () {
                              webViewEnum = WebViewEnum.stockUpdate;
                              Get.toNamed(AppRoutes.webViewScreen);
                            },
                          )
                        else if (module == 'drs')
                          DashBoardContainer(
                            text: 'DRS',
                            image: 'assets/images/dashboardimages/Delivery Boy.png',
                            ontap: () {
                              String? baseLocation = Pref().getBaseLocation();
                              if (baseLocation.isEmpty) {
                                dashBordMenuEnum = DashBordMenuEnum.drsList;
                                TmsToast.msg('Please add Location');
                              } else {
                                dashBordMenuEnum = DashBordMenuEnum.drsList;
                                DrsBottomSheetArrival(context);
                              }
                            },
                          )
                        else if (module == 'pod')
                          DashBoardContainer(
                            text: 'POD',
                            image: 'assets/images/dashboardimages/POD.png',
                            ontap: () {
                              Get.toNamed(AppRoutes.podScreen);
                            },
                          )
                        else if (module == 'tracking')
                          DashBoardContainer(
                            text: 'Tracking',
                            image: 'assets/images/dashboardimages/Tracking.png',
                            ontap: () {
                              trackingCustomBottomSheet(context);
                            },
                          )
                        else if (module == 'unloadingSheet')
                          DashBoardContainer(
                            text: 'Unloading \nSheet',
                            image: 'assets/images/dashboardimages/unloading.png',
                            ontap: () {
                              unlodingcustomBottomSheet(context);
                            },
                          )
                        else if (module == 'attendance')
                          DashBoardContainer(
                            text: 'Attendance',
                            image: 'assets/images/dashboardimages/imgpsh_fullsize_anim.png',
                            ontap: () async {
                              bool serviceEnabled = await location.serviceEnabled();
                              if (!serviceEnabled) {
                                showGpsDialog(context);
                              } else {
                                attendanceController.getAttendance(context);
                              }
                            },
                          )
                        else if (module == 'prq')
                          DashBoardContainer(
                            text: 'PRQ',
                            image: 'assets/images/dashboardimages/Delivery Boy.png',
                            ontap: () {
                              ctrl.setScheduler();
                            },
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showGpsDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(05))),
          title: Text('GPS Not Enabled'),
          content: Text('Please enable GPS to continue.'),
          actions: <Widget>[
            TmsButton(
              text: "OK",
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
