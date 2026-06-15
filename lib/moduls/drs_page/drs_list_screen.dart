import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../app_routes.dart';
import '../../utils/pref.dart';
import '../../utils/tms_color.dart';
import '../../widgets/app_size.dart';
import '../../widgets/tms_richtext.dart';
import 'drs_controller.dart';

class DRSListScreen extends StatefulWidget {
  const DRSListScreen({super.key});

  @override
  State<DRSListScreen> createState() => _DRSListScreenState();
}

class _DRSListScreenState extends State<DRSListScreen> {
  DRSController drsController = Get.put(DRSController());

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Colors.black.withOpacity(0.3),
      child: WillPopScope(
        onWillPop: () async {
          Get.toNamed(AppRoutes.drsListScreen);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'DRS List',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color(0xff232F34),
            elevation: 0,
            centerTitle: true,
            leading: InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.dashboardScreen);
              },
              child: const Icon(
                Icons.arrow_back,
                size: 30,
                color: AppColor.white,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.qRScanScreen);
                  },
                  child: const Icon(
                    Icons.document_scanner_outlined,
                    size: 30,
                    color: AppColor.white,
                  ),
                ),
              )
            ],
          ),
          body: Obx(() {
            switch (drsController.drsListDataStatus.value) {
              case DataStatus.loading:
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                        child: CircularProgressIndicator(
                      color: AppColor.blue,
                    )),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Loading...'),
                    )
                  ],
                );
              case DataStatus.error:
                return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Center(child: Text("No Data Found"))]);
              case DataStatus.done:
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Pref().getHstMode()
                            ? Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: AppSize.size(context).height * 0.04,
                                      child: TextField(
                                        controller: drsController.drsScanController,
                                        style: const TextStyle(color: Colors.black),
                                        cursorColor: Colors.transparent,
                                        decoration: const InputDecoration(
                                          labelText: 'Thc No',
                                          border: OutlineInputBorder(),
                                        ),
                                        onChanged: (value) {
                                          if (drsController.drsScanController.text.length > 11) {
                                            drsController.drsListScan(context, value, false);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      drsController.drsScanController.clear();
                                    },
                                    child: const Icon(Icons.clear),
                                  )
                                ],
                              )
                            : SizedBox(),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: drsController.drsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: drsView(
                                    drsDate: drsController.drsList[index].pdcdt,
                                    drsNo: drsController.drsList[index].pdcno,
                                    totalCNotes: '${drsController.drsList[index].toTDkt}',
                                    onTap: () {
                                      Get.toNamed(AppRoutes.docketListScreen);
                                      drsController.docketListDataStatus.value = DataStatus.loading;
                                      drsController.updateDrsApi(
                                        context: context,
                                        drsId: drsController.drsList[index].pdcno,
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
            }
          }),
        ),
      ),
    );
  }

  InkWell drsView({
    required String drsNo,
    required String drsDate,
    required String totalCNotes,
    required Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
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
            const SizedBox(
              height: 08,
            ),
            TmsRichText(
              text: "DRS No : ",
              richText: drsNo,
              color: Color(0xff232F34),
              color1: AppColor.black45,
              fontSize: 17,
              fontSize1: 14,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(children: [
              TmsImageTextView(
                text: drsController.showDate(drsDate),
                image: 'assets/images/dashboardimages/Calendar.png',
                height: 25,
                color: Color(0xff232F34),
              ),
              Spacer(),
              TmsRichText(
                text: "Total CNotes : ",
                richText: totalCNotes,
                color: Color(0xff232F34),
                color1: AppColor.black45,
                fontSize: 17,
                fontSize1: 14,
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
