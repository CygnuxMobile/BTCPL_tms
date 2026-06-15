import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../moduls/arrival_page/arrival_controller.dart';
import '../app_size.dart';
import '../dashboard_widgets/custom_drawer.dart';
import '../tms_button.dart';
import '../tms_normaltext.dart';

Future<void> submitArrivalBottomSheet(
  context, {
  required int index,
}) async {
  var ctrl = Get.find<ArrivalController>();
  final formKey = GlobalKey<FormState>();
  showModalBottomSheet(
    context: Get.context!,
    backgroundColor: Colors.transparent,
    builder: (BuildContext bc) {
      return Padding(
        padding: MediaQuery.of(bc).viewInsets,
        child: Container(
          height: AppSize.size(context).height * 0.6,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    const TmsText(
                      text: 'Submit Arrival Details',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Color(0xFF023E8A),
                        size: 35,
                      ),
                      onPressed: () {
                        Get.back();
                        ctrl1.closingKMCtrl.clear();
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: AppSize.size(context).width / 2,
                              child: TextFormField(
                                controller: ctrl1.closingKMCtrl,
                                onChanged: (val){
                                  ctrl1.closingKM = int.parse(val);

                                },
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Closing KM. ',
                                  labelStyle: TextStyle(color: Colors.black),

                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter Docket number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                splashColor: Colors.deepPurple,
                                child: Obx(() => DropdownButton(
                                      borderRadius: BorderRadius.circular(8),
                                      value: ctrl.dropdownValue.value,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      items: ctrl.items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      onChanged: (Object? val) {
                                        ctrl.onChangedValue(val.toString());
                                      },
                                    )),
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          // controller: ctrl.docketNumber,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Remarks',
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Docket number';
                            }
                            return null;
                          },
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 30,
                ),
                TmsButton(
                  onPressed: () {
                    ctrl1.ThcArrivalSubmitRequsetData(index);
                    ctrl1.closingKMCtrl.clear();

                  },
                  text: ' Submit',
                  size: const Size(double.infinity, 50),
                ),
              ],
            ),
          ),
        ),
      );
    },
    isScrollControlled: true,
  );
}
