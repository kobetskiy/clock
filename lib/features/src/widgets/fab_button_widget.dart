import 'package:flutter/material.dart';

class FABButtonWidget extends StatefulWidget {

  const FABButtonWidget({super.key, required this.icon, this.onPressed});

  final IconData icon;
  final void Function()? onPressed;

  @override
  State<FABButtonWidget> createState() => _FABButtonWidgetState();
}

class _FABButtonWidgetState extends State<FABButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: widget.onPressed,
      child: Icon(widget.icon),
    );
  }
}
