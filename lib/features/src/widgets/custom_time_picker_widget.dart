// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class CustomTimePickerWidget extends StatefulWidget {
  CustomTimePickerWidget({
    super.key,
    required this.timeValue,
    required this.maxValue,
    this.itemWidth = 60,
  });

  int timeValue;
  final int maxValue;
  final double itemWidth;

  @override
  State<CustomTimePickerWidget> createState() => _CustomTimePickerWidgetState();
}

class _CustomTimePickerWidgetState extends State<CustomTimePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NumberPicker(
            minValue: 0,
            maxValue: widget.maxValue,
            value: widget.timeValue,
            zeroPad: true,
            infiniteLoop: true,
            itemWidth: widget.itemWidth,
            itemHeight: 50,
            onChanged: (value) {
              setState(() {
                widget.timeValue = value;
              });
            },
            textStyle: const TextStyle(color: Colors.grey, fontSize: 20),
            selectedTextStyle:
                const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
