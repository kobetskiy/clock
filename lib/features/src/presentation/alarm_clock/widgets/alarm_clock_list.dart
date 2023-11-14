import 'package:clock/core/ui/colors/colors.dart';
import 'package:clock/features/src/models/view.dart';
import 'package:clock/features/src/presentation/alarm_clock/pages/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
    return SliverList.builder(
      itemCount: db.box.length,
      itemBuilder: (context, index) {
        int reversedIndex = widget.listOfAlarmClocks.length - 1 - index;
        AlarmClock alarm = widget.listOfAlarmClocks[reversedIndex];
        return Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
          child: Slidable(
            endActionPane: ActionPane(
              extentRatio: 0.3,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) => setState(() => db.delete(alarm)),
                  backgroundColor: AppColors.dangerRedColor,
                  foregroundColor: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  icon: Icons.delete,
                ),
              ],
            ),
            child: Card(
              margin: const EdgeInsets.all(0),
              child: ListTile(
                title: Text(
                  '${alarm.hours.toString().padLeft(2, '0')}:${alarm.minutes.toString().padLeft(2, '0')}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  alarm.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Transform.scale(
                  scale: 0.9,
                  child: Switch(
                    value: alarm.isOn,
                    onChanged: (val) {
                      alarm.isOn = val;
                      setState(() {});
                    },
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AlarmClockDetailsPage.routeName,
                    arguments: {
                      'alarmClock': AlarmClock(
                        isOn: alarm.isOn,
                        id: alarm.id,
                        hours: alarm.hours,
                        minutes: alarm.minutes,
                        description: alarm.description,
                      ),
                      'isNew': false,
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
