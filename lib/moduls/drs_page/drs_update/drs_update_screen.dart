import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../utils/tms_color.dart';
import '../../../widgets/app_size.dart';
import '../../../widgets/custom_dropdown_search.dart';
import '../../../widgets/tms_button.dart';
import '../../../widgets/tms_normaltext.dart';
import '../../../widgets/tms_richtext.dart';
import '../../home_page/dash_board_controller.dart';
import '../drs_controller.dart';

class DrsUpdateScreen extends StatelessWidget {
  DrsUpdateScreen({super.key});

  DRSController drsController = Get.put(DRSController());
  DashBoardController ctrl = Get.find<DashBoardController>();

  SizedBox _sizeBox() => const SizedBox(height: 12);

  SizedBox sizeBox() => const SizedBox(height: 6);

  int index = Get.arguments;
  GlobalKey<FormState> deliveredPkgsFromKey = GlobalKey<FormState>();
  GlobalKey<FormState> addRemarksFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> closeKmFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> reason = GlobalKey<FormState>();
  GlobalKey<FormState> qtyReason = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Colors.black.withOpacity(0.3),
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              size: 30,
              color: AppColor.white,
            ),
          ),
          title: const Text(
            'Drs Update',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xff232F34),
          elevation: 0,
          centerTitle: true,
        ),

        /// *********** BODY ***********
        body: SafeArea(
          child: Obx(
            () => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ---------- Top DRS Details ----------
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sizeBox(),
                            TmsRichText(
                              text: "DRS No : ",
                              richText: drsController.drsDetailData.pdcno,
                              color: Color(0xff232F34),
                              color1: AppColor.black45,
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              fontSize1: 14,
                            ),
                            sizeBox(),
                            TmsImageTextView(
                              text: drsController.drsDetailList[index].dockno,
                              icon: HugeIcons.strokeRoundedFile01,
                              height: 25,
                              color: Color(0xff4CAF50),
                              fontWeight: FontWeight.w500,
                            ),
                            sizeBox(),
                            TmsRichText(
                              text: "Delivered packages :",
                              richText: " ${drsController.drsDetailList[index].pkgsBooked}",
                              color: Color(0xff232F34),
                              color1: AppColor.black45,
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              fontSize1: 14,
                            ),
                            Row(
                              children: [
                                TmsImageTextView(
                                  text: "${drsController.drsDetailList[index].pkgsArrived}",
                                  icon: HugeIcons.strokeRoundedCalendar03,
                                  height: 25,
                                  color: Color(0xff646D72),
                                  fontWeight: FontWeight.w500,
                                ),
                                Spacer(),
                                TmsImageTextView(
                                  text: "${drsController.drsDetailList[index].pkgsPending}",
                                  icon: HugeIcons.strokeRoundedClock01,
                                  height: 25,
                                  color: Color(0xff646D72),
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    _sizeBox(),

                    /// ---------- Delivered package input ----------
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        children: [
                          const HugeIcon(
                            icon: HugeIcons.strokeRoundedCheckmarkCircle01,
                            color: Color(0xff232F34),
                            size: 25,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Form(
                                key: deliveredPkgsFromKey,
                                child: TextFormField(
                                  controller: drsController.deliveredPkgsController,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  decoration: const InputDecoration(
                                    labelText: 'Enter delivered package ',
                                    labelStyle: TextStyle(color: Colors.black),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (newValue) {
                                    drsController.deliveredPkgsValidation(newValue, index);
                                  },
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter delivered pkgs number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    _sizeBox(),

                    /// ---------- Remark ----------
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        children: [
                          const HugeIcon(
                            icon: HugeIcons.strokeRoundedComment01,
                            color: Color(0xff232F34),
                            size: 25,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Form(
                                key: addRemarksFormKey,
                                child: TextFormField(
                                  controller: drsController.drsRemarkController,
                                  decoration: const InputDecoration(
                                    labelText: 'Enter Remark',
                                    labelStyle: TextStyle(color: Colors.black),
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter remark';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    _sizeBox(),

                    /// ---------- closing km ----------

                    Padding(
                      padding: const EdgeInsets.only(
                        left: 4,
                      ),
                      child: TmsText(
                        text: "Start Km: ${drsController.drsDetailData.startKm}",
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Form(
                        key: closeKmFormKey,
                        child: TextFormField(
                          controller: drsController.closeKmController,
                          decoration: const InputDecoration(
                            labelText: 'Enter Close Km',
                            labelStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Close Km';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    _sizeBox(),

                    /// ---------- Main reason ----------
                    const TmsText(text: '* Reason', fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xff646D72)),
                    sizeBox(),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: reason,
                        child: Dropdown(
                          list: drsController.remarkList.map((data) => data.codeDesc).toList(),
                          onChanged: (value) {
                            drsController.reason = value.toString();
                          },
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'Please select reason';
                            }
                            return null;
                          },
                          text: " Select Reason ".obs,
                          isSize: true,
                          enabled: true.obs,
                        ),
                      ),
                    ),

                    _sizeBox(),

                    /// ---------- Qty reason ----------
                    drsController.isShow.isTrue
                        ? const TmsText(text: '* Drs undelivered reason ', fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xff646D72))
                        : SizedBox(),
                    sizeBox(),

                    drsController.isShow.isTrue
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: qtyReason,
                              child: Dropdown(
                                list: drsController.qtyMissRemarkList.map((data) => data.codeDesc).toList(),
                                onChanged: (value) {
                                  drsController.qtyReason = value.toString();
                                },
                                text: "  Select Reason ".obs,
                                validator: (value) {
                                  if (value == null || value == '') {
                                    return 'Please Select Reason ';
                                  }
                                  return null;
                                },
                                isSize: true,
                                enabled: true.obs,
                              ),
                            ),
                          )
                        : SizedBox(),

                    SizedBox(height: 20),

                    /// ---------- Submit button ----------
                    TmsButton(
                      text: 'Submit',
                      size: Size(double.infinity, AppSize.size(context).height * 0.06),
                      onPressed: () {
                        if (drsController.isShow.isTrue) {
                          if (deliveredPkgsFromKey.currentState!.validate() &&
                              closeKmFormKey.currentState!.validate() &&
                              addRemarksFormKey.currentState!.validate() &&
                              reason.currentState!.validate() &&
                              qtyReason.currentState!.validate()) {
                            drsController.drsSubmitApi(
                              context: context,
                              index: index,
                            );
                          }
                        } else {
                          if (deliveredPkgsFromKey.currentState!.validate() &&
                              closeKmFormKey.currentState!.validate() &&
                              addRemarksFormKey.currentState!.validate() &&
                              reason.currentState!.validate()) {
                            drsController.drsSubmitApi(
                              context: context,
                              index: index,
                            );
                          }
                        }
                      },
                    ),

                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
