import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../model/docket_model/docket.dart';
import '../../widgets/app_size.dart';
import '../../widgets/tms_normaltext.dart';
import '../../widgets/tms_richtext.dart';
import 'docket_controller.dart';

class DocketPackageScreen extends StatelessWidget {
  DocketPackageScreen({Key? key}) : super(key: key);

  DocketInfo argumentData = Get.arguments[0] as DocketInfo;
  var ctrl = Get.find<DocketController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xff232F34),
        centerTitle: true,
        title: TmsText(
          text: 'Package List',
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              SizedBox(
                height: AppSize.size(context).height * 0.020,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TmsRichText(
                    text: 'Docket No : ',
                    richText: '${argumentData.dockno}',
                    color: Color(0xff232F34),
                    color1: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize1: 15,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.size(context).height * 0.020,
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: double.parse(argumentData.pkgsno.toString()).toInt(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))),
                      margin: const EdgeInsets.only(bottom: 20),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                                      child: const HugeIcon(
                                        icon: HugeIcons.strokeRoundedQrCode,
                                        color: Color(0xff232F34),
                                        size: 80,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          TmsDocketListView(
                                              color: Color(0xff646D72),
                                              text: argumentData.dockdt,
                                              icon: HugeIcons.strokeRoundedCalendar03,
                                              height: 20),
                                          TmsDocketListView(
                                              color: Colors.blue.withOpacity(0.7),
                                              text: '${index + 1} / ${argumentData.pkgsno.toInt()}',
                                              icon: HugeIcons.strokeRoundedPackage,
                                              height: 20),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: InkWell(
                                        onTap: () async {
                                          if (!(await checkBluetoothStatus(context))) {
                                            ctrl.showBluetoothDialog(context);
                                          } else {
                                            ctrl.prnList.clear();
                                            ctrl.prnList
                                                .add(ctrl.getRglPrintData(argumentData, index));
                                            print(ctrl.prnList);

                                            ctrl.printImageByMethodChannel(arg: {
                                              "printDataList": ctrl.prnList,
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: 80,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Color(0xff232F34)),
                                          child: const Center(
                                            child: TmsText(
                                              text: 'Print',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: AppSize.size(context).height * 0.11,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color: Color(0xff646D72),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              argumentData.orgncd,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22),
                                            ),
                                            if (argumentData.csgnnm.isNotEmpty) ...{
                                              Text(
                                                "${argumentData.csgnnm.length <= 10 ? argumentData.csgnnm : argumentData.csgnnm.substring(0, 10) + "..."}",
                                                style: TextStyle(
                                                    color: Color(0xffC4CACD),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            } else ...{
                                              Text(
                                                'Origin',
                                                style: TextStyle(
                                                    color: Color(0xffC4CACD), fontSize: 16),
                                              ),
                                            }
                                          ],
                                        ),
                                      ),
                                      const HugeIcon(
                                        icon: HugeIcons.strokeRoundedArrowRight01,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              argumentData.reassigNDestcd,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22),
                                            ),
                                            if (argumentData.csgenm.isNotEmpty) ...{
                                              Text(
                                                "${argumentData.csgenm.length <= 10 ? argumentData.csgenm : argumentData.csgenm.substring(0, 10) + "..."}",
                                                style: TextStyle(
                                                    color: Color(0xffC4CACD),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            } else ...{
                                              Text(
                                                'Destination',
                                                style: TextStyle(
                                                    color: Color(0xffC4CACD), fontSize: 16),
                                              ),
                                            }
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TmsDocketListView(
      {required String text, required List<List<dynamic>> icon, required double height, required Color color}) {
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
            color: color,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  checkBluetoothStatus(BuildContext context) async {
    bool isOn = await ctrl.flutterBlueClassicPlugin.value.isEnabled;
    return isOn;
  }
}
