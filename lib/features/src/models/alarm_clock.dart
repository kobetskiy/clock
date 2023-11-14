

import 'package:hive_flutter/hive_flutter.dart';

part 'alarm_clock.g.dart';

@HiveType(typeId: 0)
class AlarmClock {

  @HiveField(0)
  final int id;

  @HiveField(1)
  bool isOn;

  @HiveField(2)
  int hours;
  
    @HiveField(3)
  int minutes;

  @HiveField(4)
  final String description;


  AlarmClock({
    required this.isOn,
    required this.id,
    required this.hours,
    required this.minutes,
    required this.description,
  });
}
