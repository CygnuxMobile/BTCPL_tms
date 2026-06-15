import 'package:flutter/material.dart';

class StepperData {
  /// title for the stepper
  final Widget? widget;

  /// subtitle for the stepper

  final Widget? textWidget;

  /// Use the constructor of [StepperData] to pass the data needed.
  StepperData( {this.textWidget,this.widget,});
}

class StepperText {
  /// text for the stepper
  final String text;

  /// textStyle for stepper
  final TextStyle? textStyle;

  StepperText(this.text, {this.textStyle});
}
