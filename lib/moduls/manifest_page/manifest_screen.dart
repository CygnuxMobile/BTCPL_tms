// ignore_for_file: must_be_immutable

import 'package:btcpl/moduls/manifest_page/sub_widget/manifest_scan_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_routes.dart';
import '../../utils/pref.dart';
import '../../widgets/app_size.dart';
import '../../widgets/custom_dropdown_search.dart';
import '../../widgets/dashboard_widgets/custom_drawer.dart';
import '../../widgets/manifest_widgets/custom_alertdialog.dart';
import '../../widgets/tms_button.dart';
import '../../widgets/tms_normaltext.dart';
import '../../widgets/tost.dart';
import 'manifest_controller.dart';

class ManifestScreen extends StatefulWidget {
  ManifestScreen({Key? key}) : super(key: key);

  @override
  State<ManifestScreen> createState() => _ManifestScreenState();
}

class _ManifestScreenState extends State<ManifestScreen> {
  var mfCtrl = Get.find<ManifestController>();

  var scaffoldKeyM = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        mfCtrl.checkValidSerialNoDataList.clear();
        Get.back();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          key: scaffoldKeyM,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  mfCtrl.checkValidSerialNoDataList.clear();
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                )),
            backgroundColor: Color(0xff232F34),
            centerTitle: true,
            title: TmsText(
              text: 'Manifest',
              fontSize: 18,
              color: Colors.white,
            ),
            actions: [
              InkWell(
                onTap: () async {
                  if (Pref().getBaseLocation().isEmpty || Pref().getNextLocation().isEmpty) {
                    mflocAlertDialog(
                        context: context,
                        title: 'Warning',
                        description: 'Please Select Location',
                        onTap: () {
                          Get.back();
                        },
                        onTapText: 'OK');
                  } else {
                    Get.toNamed(AppRoutes.qRScanScreen);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(
                    Icons.document_scanner_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        TmsText(
                          text: 'From',
                          fontSize: 14,
                          color: Color(0xff646D72),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        if (Pref().getBranchCode() == 'HQTR')
                          Obx(
                            () => Dropdown(
                                height: 25.0.obs,
                                image: "assets/images/dashboardimages/To.png".obs,
                                enabled: true.obs,
                                isSize: false,
                                text: Pref().getBaseLocation().isEmpty
                                    ? '  Select Location '.obs
                                    : '  ${Pref().getBaseLocation()}'.obs,
                                list: ctrl.location
                                    .map((element) => '${element.locCode} - ${element.locName}')
                                    .toList(),
                                onChanged: (value) async {
                                  await ctrl.getLocationCode(value!);
                                }),
                          )
                        else
                          Container(
                            alignment: Alignment.center,
                            height: AppSize.size(context).height * 0.07,
                            // width: AppSize.size(context).width * 0.75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFE9ECEF),
                            ),
                            child: DropdownSearch(
                              selectedItem: Pref().getBranchCode(),
                              enabled: false,
                              items: [Pref().getBranchCode()],
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  prefix: const Icon(
                                    Icons.location_on_outlined,
                                    color: Color(0xFF023E8A),
                                    size: 25,
                                  ),
                                  border: InputBorder.none,
                                  hintText: Pref().getBranchCode(),
                                ),
                              ),
                            ),
                          ),
                        SizedBox(
                          height: 5,
                        ),
                        TmsText(
                          text: 'To',
                          fontSize: 14,
                          color: Color(0xff646D72),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Obx(
                          () => Dropdown(
                            height: 25.0.obs,
                            image: "assets/images/dashboardimages/Form.png".obs,
                            enabled: true.obs,
                            isSize: false,
                            text: Pref().getNextLocation().isEmpty
                                ? '  Select To Location '.obs
                                : '  ${Pref().getNextLocation()}'.obs,
                            list: ctrl.location
                                .map((element) => '${element.locCode} - ${element.locName}')
                                .toList(),
                            onChanged: (value) async {
                              await Pref().saveNextLocation(val: mfCtrl.LocationName(value));
                              print('=====${Pref().getNextLocation()}');
                              mfCtrl.hideTextFocus.requestFocus();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() => mfCtrl.checkValidSerialNoDataList.isNotEmpty
                      ? ListView.builder(
                          itemCount: mfCtrl.checkValidSerialNoDataList.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            String lastScan = mfCtrl.lastScanNo(index);
                            return GestureDetector(
                              onTap: () {
                                ManifestScanDialog(
                                    context, mfCtrl.checkValidSerialNoDataList[index].bcserials);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    border:
                                        Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            TmsText(
                                              text:
                                                  mfCtrl.checkValidSerialNoDataList[index].dockno!,
                                              fontSize: 15,
                                            ),
                                            TmsManifestView(
                                                color: Color(0xff646D72),
                                                text:
                                                    "${mfCtrl.checkValidSerialNoDataList[index].docketDate}",
                                                image: 'assets/images/dashboardimages/Calendar.png',
                                                height: 25),
                                          ],
                                        ),
                                        TmsManifestView(
                                            color: Color(0xff646D72),
                                            text:
                                                '${mfCtrl.countScan(index)}/${mfCtrl.checkValidSerialNoDataList[index].bcserials!.length}',
                                            image: 'assets/images/dashboardimages/Product.png',
                                            height: 25),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : SizedBox()),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Obx(() => mfCtrl.checkValidSerialNoDataList.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TmsButton(
                    text: 'Submit',
                    onPressed: () {
                      print('------${Pref().getNextLocation()}');
                      print('------${Pref().getBaseLocation()}');
                      Pref().getBaseLocation().isNotEmpty
                          ? Pref().getNextLocation().isNotEmpty
                              ? Pref().getNextLocation() != Pref().getBaseLocation()
                                  ? mfAlertDialog(
                                      context: context,
                                      title: 'Create Manifest',
                                      description: 'Are you sure, do you want to Create Manifest ?',
                                      cancelOnTap: () {
                                        Get.back();
                                      },
                                      onTap: () async {
                                        mfCtrl.docketManifestAdd();
                                        mfCtrl.prepareManifestSubmit();
                                        // await Pref().removeBaseLocation();
                                      },
                                      onTapText: 'Create',
                                    )
                                  : TmsToast.msg('Both Location Same')
                              : TmsToast.msg('Select Next Location')
                          : TmsToast.msg('Select Base Location');
                    },
                    size: const Size(double.infinity, 40),
                  ),
                )
              : const SizedBox()),
        ),
      ),
    );
  }

  TmsManifestView(
      {required String text, required String image, required double height, required Color color}) {
    return Row(
      children: [
        Image(
          image: AssetImage(image),
          height: height,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TmsText(
            text: text,
            color: color,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
