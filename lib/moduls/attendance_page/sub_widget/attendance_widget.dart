import 'package:flutter/material.dart';

import '../../../widgets/app_size.dart';

class ClockIn extends StatelessWidget {
  const ClockIn({
    super.key,
    required this.image,
    required this.text,
    required this.icon,
    required this.iconSize,
  });

  final String image;
  final String text;
  final String icon;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.size(context).height * 0.17,
      width: AppSize.size(context).width * 0.48,
      decoration:
          BoxDecoration(image: DecorationImage(image: AssetImage(image))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(
                    width: AppSize.size(context).width * iconSize,
                    image: AssetImage(
                      icon,
                    )),
                Text(
                  text,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.title,
  });

  final String text;
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.size(context).height * 0.16,
      width: AppSize.size(context).width * 0.28,
      decoration: BoxDecoration(
          color: Color(0xffF1F0EB), borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image(
                height: AppSize.size(context).width * 0.10,
                image: AssetImage(
                  icon,
                )),
            Text(
              text.isNotEmpty ? text : "--:--",
              style: TextStyle(
                  color: Color(0xff585858),
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: TextStyle(
                color: Color(0xff585858),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
