import 'package:flutter/material.dart';

import '../../utils/tms_color.dart';
import '../tms_richtext.dart';

class MfContainer extends StatelessWidget {
  MfContainer(
      {Key? key,
      required this.text,
      required this.richText,
      required this.text1,
      required this.richText1,
      required this.text2,
      required this.richText2})
      : super(key: key);

  String text;
  String richText;
  String text1;
  String richText1;
  String text2;
  String richText2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xffE9ECEF),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TmsRichText(
            text: text,
            richText: richText,
            fontWeight: FontWeight.bold,
            fontWeight1: FontWeight.bold,
            color:  AppColor.bloodRed,
            color1: AppColor.black45,
            fontSize: 17,
            fontSize1: 17,

          ),
          const SizedBox(
            height: 8,
          ),
          Row(
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
              TmsRichText(
                text: text2,
                richText: richText2,
                fontWeight: FontWeight.bold,
                fontWeight1: FontWeight.bold,
                color:  AppColor.blue,
                color1: AppColor.black45,
                fontSize: 15,
                fontSize1: 15,
              ),
            ],
          )
        ],
      ),
    );
  }
}
