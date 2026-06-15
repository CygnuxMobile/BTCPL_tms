import 'package:flutter/material.dart';

import '../moduls/stock_update_page/stock_update_controller.dart';

class CheckboxSelectionScreen extends StatefulWidget {
  const CheckboxSelectionScreen({
    Key? key,
    required this.onChange,
    required this.selectedValue,
    required this.color,
    required this.boxType,
    required this.typeName,
    required this.isPreview,
  }) : super(key: key);

  final Function(bool? selected) onChange;
  final bool selectedValue;
  final bool isPreview;
  final DAPSEnum boxType;
  final String typeName;
  final Color color;

  @override
  _CheckboxSelectionScreenState createState() =>
      _CheckboxSelectionScreenState();
}

class _CheckboxSelectionScreenState extends State<CheckboxSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color,
          ),
        ),
        Spacer(),
        Text(widget.typeName),
        Spacer(),
        Checkbox(
          value: widget.selectedValue,
          onChanged: widget.isPreview ? null : widget.onChange,
          activeColor: stockUpdateEnum.value == StockUpdateEnum.view
              ? const Color(0xff03045E)
              : Colors.grey,
        ),
      ],
    );
  }
}
