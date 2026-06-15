import 'package:btcpl/moduls/unloading_page/unloading_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/tms_color.dart';
import '../../widgets/app_size.dart';
import '../../widgets/tms_normaltext.dart';

class UnloadingScreen extends StatelessWidget {
  UnloadingScreen({super.key});

 final UnloadingScreenController unloadingScreenController =
      Get.put(UnloadingScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.blue,
        elevation: 1,
        title: const Text('Unloading Sheet'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: AppSize.size(context).height,
              width: AppSize.size(context).width * 3,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    height: AppSize.size(context).height * 0.05,
                    decoration: const BoxDecoration(
                        color: AppColor.bloodRed,
                        border: Border(
                            top: BorderSide(
                              color: Colors.black,
                            ),
                            left: BorderSide(
                              color: Colors.black,
                            ),
                            right: BorderSide(color: Colors.black),
                            bottom: BorderSide(color: Colors.white))),
                    child: const Center(
                      child: TmsText(
                        text: ' UNLOADING SHEET',
                        fontWeight: FontWeight.bold,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                  _secondrow(context),
                  _threerow(context),
                  Container(
                    height: AppSize.size(context).height * 0.05,
                    decoration: const BoxDecoration(
                      color:AppColor.bloodRed,
                        border: Border(
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                            bottom: BorderSide(color: Colors.black))),
                  ),
                  _heder(context),
                  _billDetails(context),
                  _total(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _secondrow(context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: AppSize.size(context).height * 0.05,
            decoration: const BoxDecoration(
              color: AppColor.blue,
              border: Border(
                  left: BorderSide(color: Colors.black),
                  right: BorderSide(
                    color: Colors.black,
                  ),
                  bottom: BorderSide(
                    color: Colors.black,
                  )),
            ),
            child: const Center(
              child: TmsText(
                text: 'Route',
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: AppColor.white,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: AppSize.size(context).height * 0.05,
            decoration: const BoxDecoration(
              color: AppColor.lightBlueAccent,
              border: Border(
                right: BorderSide(
                  color: Colors.black,
                ),
                bottom: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            child: Center(
              child: Text(
                unloadingScreenController.unloadingResponse.data.route,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: AppSize.size(context).height * 0.05,
            decoration: const BoxDecoration(
              color: AppColor.blue,
              border: Border(
                right: BorderSide(
                  color: Colors.black,
                ),
                bottom: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            child: const Center(
              child: TmsText(
                text: 'ETA',
                color: AppColor.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: AppSize.size(context).height * 0.05,
            decoration: const BoxDecoration(
              color: AppColor.lightBlueAccent,
              border: Border(
                right: BorderSide(
                  color: Colors.black,
                ),
                bottom: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            child: Center(
              child: Text(
                unloadingScreenController.unloadingResponse.data.eta,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: AppSize.size(context).height * 0.05,
            decoration: const BoxDecoration(
              color: AppColor.blue,
              border: Border(
                right: BorderSide(
                  color: Colors.black,
                ),
                bottom: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            child: const Center(
              child: TmsText(
                text: 'THC Statr Location',
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: AppColor.white,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: AppSize.size(context).height * 0.05,
            decoration: const BoxDecoration(
              color: AppColor.lightBlueAccent,
              border: Border(
                right: BorderSide(
                  color: Colors.black,
                ),
                bottom: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            child: Center(
              child: Text(
                unloadingScreenController.unloadingResponse.data.orgncd,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _threerow(context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: AppSize.size(context).height * 0.05,
            decoration: const BoxDecoration(
              color: AppColor.blue,
              border: Border(
                left: BorderSide(color: Colors.black),
                right: BorderSide(
                  color: Colors.black,
                ),
                bottom: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            child: Center(
              child: TmsText(
                text: 'THC No',
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: AppColor.white,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: AppSize.size(context).height * 0.05,
            decoration: const BoxDecoration(
              color: AppColor.lightBlueAccent,
              border: Border(
                right: BorderSide(
                  color: Colors.black,
                ),
                bottom: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            child: Center(
              child: Text(
                unloadingScreenController.unloadingResponse.data.thcno,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: AppSize.size(context).height * 0.05,
            decoration: const BoxDecoration(
              color: AppColor.blue,
              border: Border(
                right: BorderSide(
                  color: Colors.black,
                ),
                bottom: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            child: const Center(
              child: TmsText(
                text: 'THC Date',
                fontWeight: FontWeight.bold,
                color: AppColor.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: AppSize.size(context).height * 0.05,
            decoration: const BoxDecoration(
              color: AppColor.lightBlueAccent,
              border: Border(
                right: BorderSide(
                  color: Colors.black,
                ),
                bottom: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            child: Center(
              child: Text(
                unloadingScreenController.unloadingResponse.data.thcdt,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: AppSize.size(context).height * 0.05,
            decoration: const BoxDecoration(
              color: AppColor.blue,
              border: Border(
                right: BorderSide(
                  color: Colors.black,
                ),
                bottom: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            child: const Center(
              child: TmsText(
                text: 'Vehicle',
                fontWeight: FontWeight.bold,
                color: AppColor.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: AppSize.size(context).height * 0.05,
            decoration: const BoxDecoration(
              color: AppColor.lightBlueAccent,
              border: Border(
                right: BorderSide(
                  color: Colors.black,
                ),
                bottom: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            child: Center(
              child: Text(
                unloadingScreenController.unloadingResponse.data.vehno,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _heder(context) {
    return Container(
      height: AppSize.size(context).height * 0.13,
      color: AppColor.blue,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    left: BorderSide(color: Colors.black),
                    right: BorderSide(
                      color: Colors.black,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                    )),
              ),
              child: const Center(
                child: Text(
                  'Sr No.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
                      color: Colors.black,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                    )),
              ),
              child: const Center(
                child: Text(
                  'CNote No./Pay basis.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
                      color: Colors.black,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                    )),
              ),
              child: const Center(
                child: Text(
                  'Mode/Service Type',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
                      color: Colors.black,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                    )),
              ),
              child: const Center(
                child: Text(
                  'Booking-Delivery DateName',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
                      color: Colors.black,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                    )),
              ),
              child: const Center(
                child: Text(
                  'Booking - Delivery Location',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
                      color: Colors.black,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                    )),
              ),
              child: const Center(
                child: Text(
                  'From - To',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
                      color: Colors.black,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                    )),
              ),
              child: const Center(
                child: Text(
                  'Consignee',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
                      color: Colors.black,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                    )),
              ),
              child: const Center(
                child: Text(
                  'Consignor',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
                      color: Colors.black,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                    )),
              ),
              child: const Center(
                child: Text(
                  'Packages Weight L/B',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
                      color: Colors.black,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                    )),
              ),
              child: const Center(
                child: Text(
                  'Weight L/B Kg',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _billDetails(contex) {
    return Expanded(
      child: Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: unloadingScreenController
                .unloadingResponse.data.getLsNoData.length,
            itemBuilder: (context, index) {
              // Return the column header row
              return Details(context, index);
            },
          )),
    );
  }

  Details(context, index) {
    return Container(
      color: AppColor.lightBlueAccent,
      height: AppSize.size(context).height * 0.20,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    left: BorderSide(color: Colors.black),
                    right: BorderSide(
                      color: Colors.black,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                    )),
              ),
              child: Center(
                child: Text(
                  "${index + 1}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
                      color: Colors.black,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                    )),
              ),
              child: Center(
                child: Text(
                  unloadingScreenController
                      .unloadingResponse.data.getLsNoData[index].dockno,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
                      color: Colors.black,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                    )),
              ),
              child: Center(
                child: Text(
                  unloadingScreenController
                      .unloadingResponse.data.getLsNoData[index].mode,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
                      color: Colors.black,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                    )),
              ),
              child: Center(
                child: Text(
                  ' ${unloadingScreenController.unloadingResponse.data.getLsNoData[index].dockno}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
                      color: Colors.black,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                    )),
              ),
              child: Center(
                child: Text(
                  unloadingScreenController
                      .unloadingResponse.data.getLsNoData[index].thcbr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
                      color: Colors.black,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                    )),
              ),
              child: Center(
                child: Text(
                  unloadingScreenController
                      .unloadingResponse.data.getLsNoData[index].location,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
                      color: Colors.black,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                    )),
              ),
              child: Center(
                child: Text(
                  unloadingScreenController
                      .unloadingResponse.data.getLsNoData[index].csgnnm,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
                      color: Colors.black,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                    )),
              ),
              child: Center(
                child: Text(
                  unloadingScreenController
                      .unloadingResponse.data.getLsNoData[index].csgenm,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
                      color: Colors.black,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                    )),
              ),
              child: Center(
                child: Text(
                  unloadingScreenController
                      .unloadingResponse.data.getLsNoData[index].nopkgs,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
                      color: Colors.black,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                    )),
              ),
              child: Center(
                child: Text(
                  unloadingScreenController
                      .unloadingResponse.data.getLsNoData[index].actuwt,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _total(context) {
    return Container(
      height: AppSize.size(context).height * 0.05,
      color: AppColor.bloodRed,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: const Center(
                child: Text(
                  'Total',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.white
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Text(
                  unloadingScreenController.getSumOfWeight().toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.white
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Text(
                  unloadingScreenController.getSumOfKg().toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                      color: AppColor.white
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
