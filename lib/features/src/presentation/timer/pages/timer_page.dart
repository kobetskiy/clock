import 'package:flutter/material.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  static const String routeName = '/timer';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('timer')),);
  }
}
