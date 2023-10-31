import 'dart:ui';
import 'package:clock/core/ui/colors/colors.dart';
import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({
    super.key,
    this.width = 150,
    this.height = 200,
    required this.child,
  });

  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
      child: AlertDialog(
        backgroundColor: AppColors.barColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        contentPadding: const EdgeInsets.all(0),
        content: SizedBox(
          width: width,
          height: height,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: AppColors.barColor,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
