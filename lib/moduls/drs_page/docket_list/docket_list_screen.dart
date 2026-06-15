import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_routes.dart';
import '../../../model/drs_model/drs_update_details/drs_update_details_response.dart';
import '../../../utils/tms_color.dart';
import '../../../widgets/tms_normaltext.dart';
import '../../../widgets/tms_richtext.dart';
import '../../home_page/dash_board_screen.dart';
import '../drs_controller.dart';

class DocketListScreen extends StatefulWidget {
  const DocketListScreen({super.key});

  @override
  State<DocketListScreen> createState() => _DocketListScreenState();
}

class _DocketListScreenState extends State<DocketListScreen> {
  DRSController drsController = Get.put(DRSController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(AppRoutes.drsListScreen);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Docket List',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xff232F34),
          elevation: 0,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.drsListScreen);
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
                  color: Color(0xffffffff),
                ),
              ),
            )
          ],
        ),
        body: Obx(() {
          switch (drsController.docketListDataStatus.value) {
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.5), width: 1),
                        ),
                        child: TmsRichText(
                          text: "DRS No : ",
                          richText: drsController.drsDetailData.pdcno,
                          color: Color(0xff232F34),
                          color1: AppColor.black45,
                          fontSize: 17,
                          fontSize1: 14,
                        ),
                      ),
                      // Pref().getHstMode()
                      //     ?
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: SizedBox(
                      //         height: AppSize.size(context).height * 0.04,
                      //         child: TextField(
                      //           controller: drsController.drsUpdateScanController,
                      //           style: const TextStyle(color: Colors.black),
                      //           cursorColor: Colors.transparent,
                      //           decoration: const InputDecoration(
                      //             labelText: 'Thc No',
                      //             border: OutlineInputBorder(),
                      //           ),
                      //           onChanged: (value) {
                      //             if (drsController.drsUpdateScanController.text.length >
                      //                 11) {
                      //               drsController.drsUpdateScan(context,value,false);
                      //             }
                      //           },
                      //         ),
                      //       ),
                      //     ),
                      //     InkWell(
                      //       onTap: () {
                      //         drsController.drsUpdateScanController.clear();
                      //       },
                      //       child: const Icon(Icons.clear),
                      //     )
                      //   ],
                      // ) : SizedBox(),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: drsController.drsDetailList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return DRSUpdateView(
                              index: index,
                              itemList: drsController.drsDetailList,
                              detailData: drsController.drsDetailData,
                              onTap: () {
                                dashBordMenuEnum = DashBordMenuEnum.drsUpdate;
                                drsController.deliveredPkgsController.text =
                                    '${drsController.drsDetailList[index].pkgsArrived}';
                                Get.toNamed(
                                  AppRoutes.drsUpdateScreen,
                                  arguments: index,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
          }
        }),
      ),
    );
  }
}

class DRSUpdateView extends StatefulWidget {
  DRSUpdateView({
    required this.index,
    required this.itemList,
    required this.detailData,
    required this.onTap,
    super.key,
  });

  final int index;
  final DrsDetailData? detailData;
  final Function() onTap;
  List<DrsDetailList> itemList;

  @override
  State<DRSUpdateView> createState() => _DRSUpdateViewState();
}

class _DRSUpdateViewState extends State<DRSUpdateView> {
  SizedBox _sizeBox() => const SizedBox(
        height: 8,
      );

  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TmsRichText(
                      text: "",
                      richText: widget.itemList[widget.index].dockno,
                      color: Color(0xff232F34),
                      color1: AppColor.black45,
                      fontSize: 17,
                      fontSize1: 14,
                    ),
                  ],
                ),
                _sizeBox(),
                Row(
                  children: [
                    if (widget
                        .itemList[widget.index].commDelyDt.isNotEmpty) ...{
                      TmsImageTextView(
                        text: widget.itemList[widget.index].commDelyDt,
                        color: Color(0xff082283),
                        image: 'assets/images/dashboardimages/Calendar.png',
                        height: 25,
                      ),
                      const Spacer(),
                    },
                    TmsImageTextView(
                      text: "${widget.itemList[widget.index].pkgsArrived}",
                      color: Color(0xff082283),
                      image: 'assets/images/dashboardimages/Product.png',
                      height: 25,
                    ),
                  ],
                ),
                _sizeBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TmsText(
                      text: widget.itemList[widget.index].orgncd,
                      color: Color(0xffC4CACD),
                      fontSize: 16,
                    ),
                    Image(
                      image: AssetImage(
                        "assets/images/dashboardimages/arrowBlack.png",
                      ),
                      height: 30,
                    ),
                    TmsText(
                        text: widget.itemList[widget.index].destcd,
                        color: Color(0xffC4CACD),
                        fontSize: 16),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
