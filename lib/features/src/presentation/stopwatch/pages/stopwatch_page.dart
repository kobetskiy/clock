import 'package:flutter/material.dart';

class StopwatchPage extends StatelessWidget {
  const StopwatchPage({super.key});

  static const String routeName = '/stopwatch';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('stopwatch')),);
  }
}
