import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_routes.dart';
import '../../utils/tms_color.dart';
import '../../widgets/tms_normaltext.dart';
import 'docket_controller.dart';

class DocketScreen extends StatelessWidget {
  DocketScreen({Key? key}) : super(key: key);

  final DocketController ctrl = Get.find<DocketController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAndToNamed(AppRoutes.dashboardScreen);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff232F34),
            centerTitle: true,
            title: Text(
              "Print Screen",
              style: TextStyle(
                color: AppColor.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Get.offAndToNamed(AppRoutes.dashboardScreen);
              },
              icon: Icon(
                Icons.arrow_back,
                color: AppColor.white,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Flexible(
                  child: Obx(() {
                    switch (ctrl.dataStatus.value) {
                      case DataStatus.loading:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case DataStatus.completed:
                        return ListView.builder(
                          itemCount: ctrl.docketData.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  // if (Pref().getDocketPaketPrint() == true) {
                                  Get.toNamed(AppRoutes.docketPackageScreen,
                                      arguments: [ctrl.docketData[index]]);
                                  // }
                                },
                                child: Obx(
                                  () => Container(
                                    child: ctrl.docketData.isNotEmpty
                                        ? docketBoxConnect(index, context)
                                        : const Text(
                                            "Data Not Found",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      case DataStatus.error:
                        return const Center(
                          child: Text('No data'),
                        );
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  docketBoxConnect(index, BuildContext context) {
    return Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TmsText(
                  text: ctrl.docketData[index].dockno,
                  fontWeight: FontWeight.bold,
                ),
                TmsDocketListView(
                    text: '${ctrl.docketData[index].pkgsno}',
                    image: 'assets/images/dashboardimages/Product.png',
                    height: 30),
              ],
            ),
            TmsDocketListView(
                text: ctrl.docketData[index].dockdt,
                image: 'assets/images/dashboardimages/Calendar.png',
                height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TmsDocketListView(
                    text: '${ctrl.docketData[index].actuwt}',
                    image: 'assets/images/dashboardimages/Scale.png',
                    height: 28),
                InkWell(
                  onTap: () async {
                    if (!await checkBluetoothStatus(context)) {
                      ctrl.showBluetoothDialog(context);
                    } else {
                      ctrl.prnList.clear();
                      int pkg = ctrl.docketData[index].pkgsno.toInt();
                      for (int j = 0; j < pkg; j++) {
                        ctrl.prnList.add(ctrl.getRglPrintData(ctrl.docketData[index], j));
                      }
                      print(ctrl.prnList);
                      ctrl.printImageByMethodChannel(arg: {
                        "printDataList": ctrl.prnList,
                      });
                    }
                  },
                  child: Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: Color(0xff232F34)),
                    child: Center(
                      child: TmsText(
                        text: "Print All",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (ctrl.docketData[index].csgnnm.isNotEmpty &&
                ctrl.docketData[index].csgenm.isNotEmpty) ...{
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${ctrl.docketData[index].csgnnm.length <= 10 ? ctrl.docketData[index].csgnnm : ctrl.docketData[index].csgnnm.substring(0, 10) + "..."}",
                      style: TextStyle(
                          color: Color(0xffC4CACD), fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Image(
                      image: AssetImage('assets/images/dashboardimages/arrowBlack.png'),
                      height: 20,
                    ),
                    Text(
                      "${ctrl.docketData[index].csgenm.length <= 10 ? ctrl.docketData[index].csgenm : ctrl.docketData[index].csgenm.substring(0, 10) + "..."}",
                      style: TextStyle(
                          color: Color(0xffC4CACD), fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
            },
          ],
        ),
      ),
    );
  }

  checkBluetoothStatus(BuildContext context) async {
    bool isOn = await ctrl.flutterBlueClassicPlugin.value.isEnabled;
    return isOn;
  }

  TmsDocketListView({required String text, required String image, required double height}) {
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
            color: Colors.black.withOpacity(0.7),
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

/*  const SizedBox(
                                width: 20,
                              ),
  ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.deepPurple, minimumSize: Size(20, 40)),
                                  onPressed: ctrl.connected.value ? ctrl.onDisconnect : null,
                                  child: const Text('disconnect'))*/
