import 'package:flutter/material.dart';

class TmsButton extends StatelessWidget {
  const TmsButton({
    Key? key,
    required this.text,
    this.color = const Color(0xff232F34),
    required this.onPressed,
    this.size,
    this.textColor,
    this.textSize,
    this.borderWidth = 0,
    this.borderColor = Colors.transparent,
  }) : super(key: key);

  final String text;
  final Color color;
  final Color? textColor;
  final VoidCallback onPressed;
  final Size? size;
  final double? textSize;
  final double borderWidth;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: size,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: borderWidth, color: borderColor),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: textSize ?? 15,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.text,
    this.color = const Color(0xff00CA75),
    required this.onPressed,
    this.size,
    this.textSize,
  }) : super(key: key);

  final String text;
  final Color color;
  final VoidCallback onPressed;
  final Size? size;
  final double? textSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: size,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(05)))),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: textSize ?? 15, color: Colors.white),
      ),
    );
  }
}
