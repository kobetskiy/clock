import 'package:clock/features/src/presentation/pages_view.dart';

class MyRouter {
  static const String initialRoute = HomePage.routeName;

  static final router = {
    HomePage.routeName: (context) => const HomePage(),
    AlarmClockPage.routeName: (context) => const AlarmClockPage(),
    AlarmClockDetailsPage.routeName: (context) => const AlarmClockDetailsPage(),
    StopwatchPage.routeName: (context) => const StopwatchPage(),
    TimerPage.routeName: (context) => const TimerPage()
  };
}
