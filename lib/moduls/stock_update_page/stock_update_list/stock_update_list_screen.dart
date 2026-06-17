import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../app_routes.dart';
import '../../../utils/tms_color.dart';
import '../../../widgets/app_size.dart';
import '../../../widgets/tms_normaltext.dart';
import '../../../widgets/tms_richtext.dart';
import '../stock_update_controller.dart';

class StockUpdateListScreen extends StatelessWidget {
  StockUpdateListScreen({super.key});

  StockUpdateController stockUpdateController =
      Get.find<StockUpdateController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();

        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Get.back();
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
            text:'Stock Update List',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Flexible(
                  child: SizedBox(
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: stockUpdateController.stockUpdatelist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: StockUpdateListView(
                            context: context,
                            index: index,
                            text: 'Vehicle No : ',
                            text1: 'Thc No : ',
                            text2: 'Thc Date : ',
                            richText: stockUpdateController
                                .stockUpdatelist[index].vehicleNo,
                            richText1: stockUpdateController
                                .stockUpdatelist[index].thcno,
                            richText2: stockUpdateController
                                .stockUpdatelist[index].thCDate,
                            onTap: () {
                              stockUpdateController.docketBcSerialList.value =
                                  stockUpdateController.stockUpdatelist[index]
                                      .docketBcSerialsList;
                              Get.toNamed(AppRoutes.stockUpdateScreen,
                                  arguments: index);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  StockUpdateListView({
    required BuildContext context,
    required String text1,
    required String richText1,
    required int index,
    required String text,
    required String richText,
    required String text2,
    required String richText2,
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
              height: 03,
            ),
            TmsRichText(
              text: "",
              richText: richText1,
              color: AppColor.black,
              fontSize: 18,
              fontSize1: 14,
            ),
            const SizedBox(
              height: 05,
            ),
            TmsImageTextView(
              text: richText,
              color: Colors.black.withOpacity(0.7),
              height: 25,
              icon: HugeIcons.strokeRoundedDeliveryTruck01,
            ),
            const SizedBox(
              height: 03,
            ),
            TmsImageTextView(
              text: richText2,
              color: Colors.black.withOpacity(0.7),
              height: 25,
              icon: HugeIcons.strokeRoundedCalendar03,
            ),
          ],
        ),
      ),
    );
  }
}
