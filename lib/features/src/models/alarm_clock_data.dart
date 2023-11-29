import 'package:hive_flutter/hive_flutter.dart';

import 'alarm_clock.dart';

class AlarmClockData {

  final box = Hive.box<AlarmClock>('alarm_clock_box');

  void create(AlarmClock alarmClock) {
    box.put(alarmClock.id, alarmClock);
  }

  void update(AlarmClock alarmClock) {
    box.put(alarmClock.id, alarmClock);
  }

  void delete(AlarmClock alarmClock) {
    box.delete(alarmClock.id);
  }
}
