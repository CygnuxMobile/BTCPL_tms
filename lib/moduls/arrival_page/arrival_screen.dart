import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../widgets/app_size.dart';
import '../../widgets/arrival_widgets/custom_bottamsheet.dart';
import '../../widgets/dashboard_widgets/custom_drawer.dart';
import '../../widgets/tms_normaltext.dart';
import '../docket_page/docket_controller.dart';
import 'arrival_controller.dart';


class ArrivalScreen extends GetView {
  var ctrl = Get.find<ArrivalController>();

  ArrivalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            )),
        backgroundColor: Color(0xff232F34),
        title: const TmsText(
          text: 'Arrival',
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {
                customBottomSheetArrival(context);
              },
              icon: const Icon(
                Icons.edit_calendar,
                color: Colors.white,
                size: 28,
              ),
            ),
          )
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(() {
        if (ctrl.arrivalDataStatus.value == DataStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xff232F34),
            ),
          );
        }

        return ctrl.thcArrivalsData.isNotEmpty
            ? ListView.builder(
                itemCount: ctrl.thcArrivalsData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TmsText(
                                text: ctrl.thcArrivalsData[index].thcno,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TmsArrivalView(
                                text: ctrl.thcArrivalsData[index].thcDate,
                                icon: HugeIcons.strokeRoundedCalendar03,
                                height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TmsArrivalView(
                                    text: ctrl.thcArrivalsData[index].vehicle,
                                    icon: HugeIcons.strokeRoundedDeliveryTruck01,
                                    height: 28),
                                InkWell(
                                  onTap: () {
                                    submitArrivalBottomSheet(context, index: index);
                                  },
                                  child: Container(
                                    width: AppSize.size(context).width * 0.25,
                                    height: AppSize.size(context).height * 0.05,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xff232F34)),
                                    child: const Center(
                                      child: TmsText(
                                        text: 'Submit',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: Text(
                  'NoData',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 22,
                  ),
                ),
              );
      }),
    );
  }

  TmsArrivalView({required String text, required List<List<dynamic>> icon, required double height}) {
    return Row(
      children: [
        HugeIcon(
          icon: icon,
          color: const Color(0xff232F34),
          size: height,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TmsText(
            text: text,
            color: Colors.black.withOpacity(0.7),
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
