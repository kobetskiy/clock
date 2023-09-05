import 'package:flutter/material.dart';
import 'package:clock/features/core/router/router.dart';
import 'package:clock/features/core/theme/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      initialRoute: '/',
      routes: router,
    );
  }
}
