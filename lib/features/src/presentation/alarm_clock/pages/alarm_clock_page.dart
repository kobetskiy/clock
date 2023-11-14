import 'package:clock/features/src/models/view.dart';
import 'package:clock/features/src/presentation/alarm_clock/pages/alarm_clock_details_page.dart';
import 'package:clock/features/src/widgets/view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widgets/view.dart';

AlarmClockData db = AlarmClockData();

class AlarmClockPage extends StatelessWidget {
  const AlarmClockPage({super.key});

  static const String routeName = '/clock';

  String alarmClockOnCount() {
    if (List<AlarmClock>.from(db.box.values).isEmpty) {
      return 'No alarms on';
    } else if (List<AlarmClock>.from(db.box.values).length == 1) {
      return '1 alarm on';
    } else {
      return '${List<AlarmClock>.from(db.box.values).length} alarms on';
    }
  }

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
                      const SizedBox(height: 25),
                      const CircleClockWidget(),
                      const SizedBox(height: 15),
                      Text(
                        alarmClockOnCount(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: ValueListenableBuilder(
                  valueListenable: db.box.listenable(),
                  builder: (context, _, __) => AlarmClockList(
                    listOfAlarmClocks: List<AlarmClock>.from(db.box.values),
                  ),
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
                  Navigator.pushNamed(
                    context,
                    AlarmClockDetailsPage.routeName,
                    arguments: {
                      'alarmClock': AlarmClock(
                        isOn: true,
                        id: db.box.length,
                        hours: DateTime.now().hour,
                        minutes: DateTime.now().minute,
                        description: 'Alarm',
                      ),
                      'isNew': true,
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
