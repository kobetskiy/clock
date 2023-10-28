

import 'package:hive_flutter/hive_flutter.dart';

part 'alarm_clock.g.dart';

@HiveType(typeId: 0)
class AlarmClock {
  @HiveField(0)
  final bool isOn;

  @HiveField(1)
  final String time;
  
  @HiveField(2)
  final String description;

  @HiveField(3)
  final int id;

  AlarmClock({
    required this.isOn,
    required this.time,
    required this.description,
    required this.id
  });
}
