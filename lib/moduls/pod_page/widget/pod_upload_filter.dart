import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../widgets/tms_button.dart';
import '../pod_controller.dart';

podUploadBottomSheet(BuildContext context, PodUploadController podUploadController) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (builder) {
      return StatefulBuilder(
        builder: (_, setState) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              color: Colors.transparent,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Center(
                      child: Container(
                        height: 5,
                        width: 65,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    /// Lr Number
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 12.0),
                    //   child: Text("Lr Number", style: TextStyle(fontSize: 12)),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    //   child: TextField(
                    //     controller: podUploadController.lrNumberController,
                    //     decoration: InputDecoration(
                    //       hintText: "Enter Lr Number",
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(16),
                    //         borderSide: BorderSide(color: Colors.black),
                    //       ),
                    //       contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    //     ),
                    //     style: TextStyle(fontSize: 16),
                    //   ),
                    // ),
                    //
                    // const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text("Start Date", style: TextStyle(fontSize: 12)),
                    ),
                    const SizedBox(height: 3),

                    /// Start Date
                    Obx(() {
                      return GestureDetector(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: podUploadController.formDate.value.text.isNotEmpty
                                ? DateFormat('d MMM yyyy')
                                    .parse(podUploadController.formDate.value.text)
                                : DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            setState(() {
                              podUploadController.formDate.value.text =
                                  DateFormat('d MMM yyyy').format(picked);
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                children: [
                                  Text(
                                    podUploadController.formDate.value.text.isNotEmpty
                                        ? podUploadController.formDate.value.text
                                        : "Select Start Date",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.calendar_month),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text("End Date", style: TextStyle(fontSize: 12)),
                    ),
                    const SizedBox(height: 3),

                    /// End Date
                    Obx(() {
                      return GestureDetector(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: podUploadController.toDate.value.text.isNotEmpty
                                ? DateFormat('d MMM yyyy')
                                    .parse(podUploadController.toDate.value.text)
                                : DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            setState(() {
                              podUploadController.toDate.value.text =
                                  DateFormat('d MMM yyyy').format(picked);
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                children: [
                                  Text(
                                    podUploadController.toDate.value.text.isNotEmpty
                                        ? podUploadController.toDate.value.text
                                        : "Select End Date",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.calendar_month),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 20),

                    /// Apply Button
                    Center(
                      child: SizedBox(
                        child: TmsButton(
                          color: Color(0xff232F34),
                          onPressed: () {
                            podUploadController.podListApi();
                            Future.delayed(const Duration(milliseconds: 500), () {
                              Get.back();
                            });
                          },
                          text: "Apply Filter",
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
