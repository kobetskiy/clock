import 'package:clock/features/src/models/view.dart';
import 'package:clock/features/src/widgets/view.dart';
import 'package:flutter/material.dart';

import '../widgets/view.dart';

AlarmClockData db = AlarmClockData();

String _alarmClocksCount() {
  if (List<AlarmClock>.from(db.box.values).isEmpty) {
    return 'No alarms on';
  } else if (List<AlarmClock>.from(db.box.values).length == 1) {
    return '1 alarn';
  }
  return '${List<AlarmClock>.from(db.box.values).length} alarms on';
}

class AlarmClockPage extends StatelessWidget {
  const AlarmClockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                const AppBarWidget(text: 'Alarm clock'),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 35),
                      const CircleClockWidget(),
                      const SizedBox(height: 15),
                      Text(_alarmClocksCount(),
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                AlarmClockList(
                    listOfAlarmClocks: List<AlarmClock>.from(db.box.values)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FABButtonWidget(
                  icon: Icons.add,
                  onPressed: () {
                    // db.box.deleteAll(db.box.keys);
                    db.create(
                      AlarmClock(
                        isOn: true,
                        time: '11:32',
                        description: 'description',
                        id: db.box.values.length + 1,
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
