import 'package:btcpl/widgets/tms_normaltext.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class TmsRichText extends StatelessWidget {
  const TmsRichText(
      {Key? key,
      required this.text,
      this.fontSize = 18,
      this.color = Colors.black,
      this.fontWeight = FontWeight.normal,
      required this.richText,
      this.fontSize1 = 18,
      this.color1 = Colors.black,
      this.fontWeight1 = FontWeight.normal})
      : super(key: key);

  final String text;
  final String richText;
  final double fontSize;
  final double fontSize1;
  final Color color;
  final Color color1;
  final FontWeight fontWeight;
  final FontWeight fontWeight1;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize1,
          color: color1,
          fontWeight: fontWeight1,
        ),
        children: <TextSpan>[
          TextSpan(
            text: richText,
            style: TextStyle(
              fontSize: fontSize,
              color: color,
              fontWeight: fontWeight,
            ),
          ),
        ],
      ),
    );
  }
}

class TmsImageTextView extends StatelessWidget {
   TmsImageTextView(
      {super.key,
      required this.text,
      required this.icon,
      required this.height,
      required this.color,
      this.fontWeight,
      });

  final String text;
  final List<List<dynamic>> icon;
  final double height;
  final Color color;
  FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
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
            fontWeight: fontWeight ?? FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
