import 'package:clock/features/src/models/view.dart';
import 'package:clock/features/src/presentation/alarm_clock/pages/alarm_clock_details_page.dart';
import 'package:clock/features/src/widgets/view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widgets/view.dart';

class AlarmClockPage extends StatefulWidget {
  const AlarmClockPage({super.key});

  static const String routeName = '/clock';

  @override
  State<AlarmClockPage> createState() => _AlarmClockPageState();
}

class _AlarmClockPageState extends State<AlarmClockPage> {
  AlarmClockData db = AlarmClockData();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          ValueListenableBuilder(
              valueListenable: db.box.listenable(),
              builder: (context, box, child) {
                return CustomScrollView(
                  slivers: [
                    const AppBarWidget(text: 'Alarm clock'),
                    const SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          children: [
                            SizedBox(height: 25),
                            CircleClockWidget(),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                    db.box.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(8.0),
                            sliver: AlarmClockListWidget(
                              listOfAlarmClocks:
                                  List<AlarmClock>.from(db.box.values),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: Center(
                              child: Text('You have no alarms'),
                            ),
                          ),
                  ],
                );
              }),
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
