import 'package:flutter/material.dart';

class DashBoardContainer extends StatelessWidget {
  const DashBoardContainer({
    Key? key,
    required this.text,
    required this.icon,
    required this.ontap,
  }) : super(key: key);

  final String text;
  final Widget icon;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1.5),
          color: const Color(0xFFE9ECEF), // Light grey background like screenshot
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 15),
            icon,
          ],
        ),
      ),
    );
  }
}
