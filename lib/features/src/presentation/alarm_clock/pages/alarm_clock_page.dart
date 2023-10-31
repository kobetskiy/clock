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
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const AppBarWidget(text: 'Alarm clock'),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                sliver: SliverToBoxAdapter(
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
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: AlarmClockList(
                  listOfAlarmClocks: List<AlarmClock>.from(db.box.values),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FABButtonWidget(
                icon: Icons.add,
                onPressed: () {
                  Navigator.pushNamed(context, '/clock/details');
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
