import 'package:flutter/material.dart';

class PrimaryButtonWidget extends StatelessWidget {
  const PrimaryButtonWidget(
      {super.key,
      required this.onPressed,
      required this.child,
      this.width = 85,
      this.height = 14,
      this.isOutlined = false, this.foregroundColor});

  final void Function()? onPressed;
  final Widget? child;
  final double width;
  final double height;
  final bool isOutlined;
  final MaterialStateProperty<Color?>? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return isOutlined
        ? OutlinedButton(
            style: ButtonStyle(
              padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: height, horizontal: width)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
              ),
            ),
            onPressed: onPressed,
            child: child,
          )
        : ElevatedButton(
            style: ButtonStyle(
              foregroundColor: foregroundColor,
              padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: height, horizontal: width)),
              
            ),
            onPressed: onPressed,
            child: child,
          );
  }
}
