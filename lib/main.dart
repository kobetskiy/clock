import 'package:flutter/material.dart';
import 'core/router/router.dart';
import 'core/ui/theme/theme.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/src/models/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
  Hive.registerAdapter(AlarmClockAdapter());
  await Hive.openBox<AlarmClock>('alarm_clock_box');
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
