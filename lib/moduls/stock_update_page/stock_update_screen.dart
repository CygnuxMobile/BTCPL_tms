import 'dart:io';

import 'package:btcpl/moduls/stock_update_page/stock_update_controller.dart';
import 'package:btcpl/moduls/stock_update_page/stock_update_scanned_docket_number.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../app_routes.dart';
import '../../model/stock_update/stock_update_list/stock_update_list_response.dart';
import '../../utils/pref.dart';
import '../../utils/tms_color.dart';
import '../../widgets/Daps_indicator.dart';
import '../../widgets/manifest_widgets/custom_alertdialog.dart';
import '../../widgets/tms_button.dart';
import '../../widgets/tms_normaltext.dart';
import '../../widgets/tms_richtext.dart';
import '../../widgets/tost.dart';

class StockUpdate extends StatefulWidget {
  const StockUpdate({super.key});

  @override
  State<StockUpdate> createState() => _StockUpdateState();
}

class _StockUpdateState extends State<StockUpdate> {
  StockUpdateController stockUpdateController = Get.find<StockUpdateController>();

  List<File> selectedImages = [];

  int listIndex(BuildContext context) {
    int index = Get.arguments ?? 0;
    return index;
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Colors.black.withOpacity(0.3),
      child: WillPopScope(
        onWillPop: () async {
          if (stockUpdateEnum.value == StockUpdateEnum.preview) {
            stockUpdateEnum.value = StockUpdateEnum.view;
          } else {
            Get.back();
          }
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                if (stockUpdateEnum.value == StockUpdateEnum.preview) {
                  stockUpdateEnum.value = StockUpdateEnum.view;
                } else {
                  Get.back();
                }
              },
              child: const Icon(
                Icons.arrow_back_outlined,
                size: 30,
                color: Colors.white,
              ),
            ),
            backgroundColor: Color(0xff232F34),
            title: TmsText(
              color: Colors.white,
              text: stockUpdateEnum.value == StockUpdateEnum.preview
                  ? 'Stock Update Preview '
                  : 'Stock Update',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: InkWell(
                  onTap: () async {
                    String? baseLocation = Pref().getBaseLocation();
                    if (baseLocation.isEmpty) {
                      mflocAlertDialog(
                          context: context,
                          title: 'Warning',
                          description: 'Please Select Location',
                          onTap: () {
                            Get.back();
                          },
                          onTapText: 'ok');
                    } else {
                      Get.toNamed(AppRoutes.qRScanScreen);
                    }
                  },
                  child: stockUpdateEnum.value == StockUpdateEnum.preview
                      ? const SizedBox()
                      : const Icon(
                          Icons.document_scanner_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                ),
              )
            ],
            centerTitle: true,
            elevation: 0,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            controller: stockUpdateController.bsScanController,
                            focusNode: stockUpdateController.scanFocusNode,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            onChanged: (value) {
                              stockUpdateController.StockUpdatecheckScan(context, value, false);
                            },
                            decoration: InputDecoration(
                              labelText: 'Scan Box Number',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff232F34),
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 10,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                color: Colors.black,
                                onPressed: () {
                                  stockUpdateController.bsScanController.clear();
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (stockUpdateController.scanFocusNode.hasFocus) {
                            stockUpdateController.scanFocusNode.unfocus();
                          } else {
                            stockUpdateController.scanFocusNode.requestFocus();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff232F34),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Icon(
                          Icons.dock,
                          color: Colors.white,
                          size: 24,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Obx(
                  () => Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      // height: AppSize.size(context).height * 0.8,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemCount: stockUpdateController.docketBcSerialList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                            child: StockUpdateView(
                              index: index,
                              text: 'Docket No : ',
                              text1: 'BS No : ',
                              docketBcSerialList: stockUpdateController.docketBcSerialList[index],
                              onTap: () {
                                if (stockUpdateController.docketBcSerialList[index].isScan.value) {
                                  stockUpdateController.BSNumberController.text =
                                      stockUpdateController.docketBcSerialList[index].bcSerialNo;
                                  Get.to(StockUpdateScannedDocketNumberScreen(
                                    // context: context,
                                    index: index,
                                    title: 'Scanned Docket Number',
                                    onTapText: ' Done ',
                                    bcNumber:
                                        stockUpdateController.docketBcSerialList[index].bcSerialNo,
                                    onTap: () {
                                      Get.back();
                                    },
                                    cancelOnTap: () {
                                      Get.back();
                                    },
                                    isPreview: stockUpdateEnum.value == StockUpdateEnum.view
                                        ? false
                                        : true,
                                    docketBcSerialList:
                                        stockUpdateController.docketBcSerialList[index],
                                  ));

                                  // ScannedStockUpdateAlertDialog(
                                  //   context: context,
                                  //   index: index,
                                  //   title: 'Scanned Docket Number',
                                  //   onTapText: ' Done ',
                                  //   bcNumber: stockUpdateController
                                  //       .docketBcSerialList[index].bcSerialNo,
                                  //   onTap: () {
                                  //     Get.back();
                                  //   },
                                  //   cancelOnTap: () {
                                  //     Get.back();
                                  //   },
                                  //   isPreview: stockUpdateEnum.value ==
                                  //       StockUpdateEnum.view
                                  //       ? false
                                  //       : true,
                                  //   docketBcSerialList: stockUpdateController
                                  //       .docketBcSerialList[index],
                                  // );
                                } else {
                                  TmsToast.msg('Please Scan BasicSerialNo');
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                  child: TmsButton(
                    text: 'Submit',
                    size: const Size(double.infinity, 50),
                    onPressed: () {
                      stockUpdateController.stockUpdateDetails(
                        context: context,
                        index: listIndex(context),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StockUpdateView extends StatefulWidget {
  const StockUpdateView(
      {required this.index,
      required this.text,
      required this.text1,
      this.onTap,
      required this.docketBcSerialList,
      super.key});

  final int index;
  final String text;
  final String text1;
  final Function()? onTap;
  final DocketBcSerialList docketBcSerialList;

  @override
  State<StockUpdateView> createState() => _StockUpdateViewState();
}

class _StockUpdateViewState extends State<StockUpdateView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                children: [
                  Obx(() {
                    return TmsRichText(
                      text: widget.text1,
                      richText: widget.docketBcSerialList.bcSerialNo,
                      color: widget.docketBcSerialList.isScan.value
                          ? Color(0xff4CAF50)
                          : Colors.black.withOpacity(0.7),
                      color1: AppColor.black45,
                      fontSize: 17,
                      fontSize1: 14,
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                TmsImageTextView(
                  color: Colors.black.withOpacity(0.7),
                  text: widget.docketBcSerialList.dockno,
                  icon: HugeIcons.strokeRoundedFile01,
                  height: 25,
                ),
                const Spacer(),
                Obx(
                  () => HugeIcon(
                    icon: HugeIcons.strokeRoundedCheckmarkCircle01,
                    color: widget.docketBcSerialList.isScan.value
                        ? Colors.green
                        : Colors.grey,
                    size: 20,
                  ),
                ),
              ],
            ),
            Obx(
              () => ColorCirclesWidget(
                red: RxBool(widget.docketBcSerialList.isDamage.value),
                yellow: RxBool(widget.docketBcSerialList.isAccess.value),
                green: RxBool(widget.docketBcSerialList.isShortage.value),
                blue: RxBool(widget.docketBcSerialList.isPillFill.value),
                redText: 'Damage'.obs,
                yellowText: 'Access'.obs,
                greenText: ' Shortage'.obs,
                blueText: 'PillFill'.obs,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
