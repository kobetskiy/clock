// ignore_for_file: unused_local_variable

import 'package:clock/features/src/models/view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AlarmClockList extends StatefulWidget {
  const AlarmClockList({super.key, required this.listOfAlarmClocks});

  final List<AlarmClock> listOfAlarmClocks;

  @override
  State<AlarmClockList> createState() => _AlarmClockListState();
}

class _AlarmClockListState extends State<AlarmClockList> {
  AlarmClockData db = AlarmClockData();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: db.box.listenable(),
      builder: (context, value, child) => SliverList.builder(
        itemCount: db.box.length,
        itemBuilder: (context, index) {
          int reversedIndex = widget.listOfAlarmClocks.length - 1 - index;
          return Card(
          borderOnForeground: false,
          child: ListTile(
            title: Text(
              widget.listOfAlarmClocks[0].time,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              widget.listOfAlarmClocks[0].description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Switch(value: widget.listOfAlarmClocks[0].isOn, onChanged: (val) {}),
            onTap: () {},
          ),
        );
        },
      ),
    );
  }
}
