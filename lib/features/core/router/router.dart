

import 'package:clock/features/src/presentation/pages_view.dart';

final router = {
  '/': (context) => const AlarmClockPage(),
  '/clock_details': (context) => const AlarmClockDetailsPage(),
  '/stopwatch': (context) => const StopwatchPage(),
  '/timer': (context) => const TimerPage()
};
