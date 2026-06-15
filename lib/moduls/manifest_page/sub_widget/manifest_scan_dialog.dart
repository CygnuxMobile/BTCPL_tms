import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/manifest_model/manifest_details.dart';
import '../../../widgets/app_size.dart';
import '../../../widgets/tms_button.dart';
import '../../../widgets/tms_normaltext.dart';
import '../../../widgets/tms_richtext.dart';

ManifestScanDialog(BuildContext context, List<Bcserial>? bcserials) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.zero,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              TmsText(
                text: 'Scan Manifest',
                color: Color(0xff232F34),
                fontWeight: FontWeight.w500,
              ),
              Divider(
                thickness: 2,
                color: Color(0xff232F34),
              ),
              Container(
                height: AppSize.size(context).height / 2.5,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var bcserial in bcserials!) ...{
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  TmsRichText(
                                    text: "",
                                    richText: bcserial.bcSerialNo,
                                    fontSize: 12,
                                    fontSize1: 12,
                                    color1: Color(0xff646D72),
                                    color: Color(0xff232F34),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  Spacer(),
                                  Icon(
                                    bcserial.isScanPkg == true
                                        ? Icons.done
                                        : Icons.dangerous_outlined,
                                    color: bcserial.isScanPkg == true
                                        ? Colors.greenAccent
                                        : Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      },
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TmsButton(
                    text: "Back",
                    onPressed: () {
                      Get.back();
                    }),
              )
            ],
          ),
        ),
      );
    },
  );
}
