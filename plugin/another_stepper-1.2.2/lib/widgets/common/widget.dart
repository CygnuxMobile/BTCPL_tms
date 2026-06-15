import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/utils/utils.dart';
import 'package:flutter/material.dart';

class widget extends StatelessWidget {
  const widget({
    Key? key,
    required this.item,
    required this.index,
    required this.totalLength,
    required this.activeIndex,
    this.widgetHeight,
    this.widgetWidth,
  }) : super(key: key);

  /// Stepper item of type [StepperData] to inflate stepper with data
  final StepperData item;

  /// Index at which the item is present
  final int index;

  /// Total length of the list provided
  final int totalLength;

  /// Active index which needs to be highlighted and before that
  final int activeIndex;

  /// Height of [StepperData.iconWidget]
  final double? widgetHeight;

  /// Width of [StepperData.iconWidget]
  final double? widgetWidth;

  @override
  Widget build(BuildContext context) {
    return index <= activeIndex
        ? SizedBox(height: widgetHeight, width: widgetWidth, child: item.widget)
        : item.textWidget != null
            ? SizedBox(
                height: widgetHeight, width: widgetWidth, child: item.widget)
            : ColorFiltered(
                colorFilter: Utils.getGreyScaleColorFilter(),
                child: SizedBox(
                    height: widgetHeight,
                    width: widgetWidth,
                    child: item.widget),
              );
  }
}
