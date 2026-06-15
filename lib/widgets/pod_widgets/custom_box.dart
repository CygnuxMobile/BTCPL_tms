import 'package:flutter/material.dart';

import '../app_size.dart';

class PodContainer extends StatelessWidget {
  const PodContainer(
      {Key? key, required this.text, required this.image, required this.ontap})
      : super(key: key);

  final String text;
  final String image;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFE9ECEF),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image(
              image: AssetImage(image),
              height: AppSize.size(context).height * 0.10,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
          ],
        ),
      ),
    );
  }
}
