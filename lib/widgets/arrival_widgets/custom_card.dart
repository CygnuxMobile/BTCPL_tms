import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/tms_color.dart';
import '../app_size.dart';
import '../tms_button.dart';
import '../tms_richtext.dart';
import 'custom_bottamsheet.dart';

class ArrivalContainer extends GetView {
  ArrivalContainer({
    Key? key,
    required this.text,
    required this.text1,
    required this.text2,
    required this.richText,
    required this.richText2,
    required this.richText1,
    required this.index,
  }) : super(key: key);

  String text;
  String richText;
  String text1;
  String richText1;
  String text2;
  String richText2;
  int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: TmsRichText(
              text: text,
              richText: richText,
              fontWeight: FontWeight.bold,
              fontWeight1: FontWeight.bold,
              color:  AppColor.bloodRed,
              color1: AppColor.black45,
              fontSize: 17,
              fontSize1: 17,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: TmsRichText(
              text: text2,
              richText: richText2,
              fontWeight: FontWeight.bold,
              fontWeight1: FontWeight.bold,
              color:  AppColor.blue,
              color1: AppColor.black45,
              fontSize: 15,
              fontSize1: 15,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TmsRichText(
                text: text1,
                richText: richText1,
                fontWeight: FontWeight.bold,
                fontWeight1: FontWeight.bold,
                color:  AppColor.blue,
                color1: AppColor.black45,
                fontSize: 15,
                fontSize1: 15,
              ),
              const Spacer(),
              TmsButton(
                text: 'Submit',
                textSize: 12,
                size: Size(10, AppSize.size(context).height*0.04),
                onPressed: () {
                  submitArrivalBottomSheet(context, index: index);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
