import 'package:flutter/material.dart';

class CircleClockWidget extends StatefulWidget {
  const CircleClockWidget({super.key});

  @override
  State<CircleClockWidget> createState() => _CircleClockWidgetState();
}

class _CircleClockWidgetState extends State<CircleClockWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      child: const Placeholder(),
    );
  }
}
