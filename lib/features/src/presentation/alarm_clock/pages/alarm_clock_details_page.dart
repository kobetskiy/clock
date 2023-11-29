import 'package:clock/core/ui/colors/colors.dart';
import 'package:clock/features/src/models/view.dart';
import 'package:clock/features/src/presentation/alarm_clock/widgets/view.dart';
import 'package:clock/features/src/widgets/view.dart';
import 'package:flutter/material.dart';

class AlarmClockDetailsPage extends StatefulWidget {
  const AlarmClockDetailsPage({super.key});

  static const String routeName = 'clock/details';

  @override
  State<AlarmClockDetailsPage> createState() => _AlarmClockDetailsPageState();
}

class _AlarmClockDetailsPageState extends State<AlarmClockDetailsPage> {
  late AlarmClockData db = AlarmClockData();
  bool isInit = true;

  late final Map<String, dynamic> args;
  late final bool isNew;
  late final AlarmClock alarmClock;
  late final TextEditingController descriptionTextController;
  late String alarmDescription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      isNew = args['isNew'];
      alarmClock = args['alarmClock'];
      alarmDescription = alarmClock.description;
      descriptionTextController = TextEditingController(text: alarmDescription);
      isInit = false;
    }
  }

  SnackBar infoSnackBar(String title) {
    return SnackBar(
      content: Text(title, style: Theme.of(context).textTheme.labelMedium),
      duration: const Duration(seconds: 4),
      backgroundColor: AppColors.barColor,
      behavior: SnackBarBehavior.floating,
      elevation: 5,
      margin: const EdgeInsets.all(10),
    );
  }

  Future<T?> alertDialog<T>({
    required String title,
    required Widget buttons,
    Widget? action,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialogWidget(
        height: action != null ? 190 : 150,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: action != null
                ? MainAxisAlignment.spaceEvenly
                : MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Center(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              action != null ? const SizedBox(height: 10) : const SizedBox(),
              Center(child: action),
              const SizedBox(height: 20),
              buttons,
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void saveAlarm() {
      if (isNew) {
        AlarmClock newAlarm = AlarmClock(
          isOn: true,
          id: db.box.length,
          hours: alarmClock.hours,
          minutes: alarmClock.minutes,
          description: alarmDescription,
        );
        db.create(newAlarm);
      }
    }

    void updateAlarm() {
      if (!isNew) {
        AlarmClock thisNote = AlarmClock(
          isOn: true,
          id: alarmClock.id,
          hours: alarmClock.hours,
          minutes: alarmClock.minutes,
          description: alarmDescription,
        );
        db.update(thisNote);
      }
      setState(() {});
    }

    void onDeleted() {
      alertDialog(
        title: 'Are you sure?',
        action: Text(
          'This alarm will be deleted forever',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        buttons: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButtonWidget(
              isOutlined: true,
              width: 35,
              height: 12,
              onPressed: () => Navigator.maybePop(context),
              child: const Text('CANCEL'),
            ),
            const SizedBox(width: 10),
            PrimaryButtonWidget(
              width: 35,
              height: 12,
              foregroundColor:
                  const MaterialStatePropertyAll(AppColors.dangerRedColor),
              onPressed: () {
                db.delete(alarmClock);
                ScaffoldMessenger.of(context)
                    .showSnackBar(infoSnackBar('Alarm has been deleted'));
                Navigator.of(context, rootNavigator: true)
                    .popUntil(ModalRoute.withName('/'));
              },
              child: const Text('DELETE'),
            ),
          ],
        ),
      );
    }

    void onBackButtonPressed() {
      alertDialog(
        title: 'Save alarm?',
        buttons: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButtonWidget(
              isOutlined: true,
              width: 50,
              height: 12,
              onPressed: () => Navigator.of(context, rootNavigator: true)
                  .popUntil(ModalRoute.withName('/')),
              child: const Text('NO'),
            ),
            const SizedBox(width: 10),
            PrimaryButtonWidget(
              width: 50,
              height: 12,
              onPressed: () {
                isNew ? saveAlarm() : updateAlarm();
                ScaffoldMessenger.of(context)
                    .showSnackBar(infoSnackBar('The alarm clock will ring in'));
                Navigator.of(context, rootNavigator: true)
                    .popUntil(ModalRoute.withName('/'));
              },
              child: const Text('YES'),
            ),
          ],
        ),
      );
    }

    void onDesriptionPressed() {
      alertDialog(
        title: 'New Description',
        action: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: descriptionTextController,
            autofocus: true,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 2),
            ),
          ),
        ),
        buttons: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButtonWidget(
              isOutlined: true,
              width: 35,
              height: 12,
              onPressed: () {
                descriptionTextController.text = alarmDescription;
                Navigator.maybePop(context);
              },
              child: const Text('CANCEL'),
            ),
            const SizedBox(width: 10),
            PrimaryButtonWidget(
              width: 50,
              height: 12,
              onPressed: () {
                alarmDescription = descriptionTextController.text;
                setState(() {});
                Navigator.maybePop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            AppBarWidget(
              text: 'New alarm',
              leading: IconButton(
                onPressed: () => setState(() => onBackButtonPressed()),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                ),
              ),
              action: [
                IconButton(
                  onPressed: () {
                    isNew ? saveAlarm() : updateAlarm();
                    Navigator.maybePop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        infoSnackBar('The alarm clock will ring in'));
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.check_rounded,
                  ),
                )
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 40),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTimePickerWidget(
                      timeValue: alarmClock.hours,
                      maxValue: 23,
                      onChanged: (value) => alarmClock.hours = value,
                    ),
                    const Text(':', style: TextStyle(fontSize: 36)),
                    CustomTimePickerWidget(
                      timeValue: alarmClock.minutes,
                      maxValue: 59,
                      onChanged: (value) => alarmClock.minutes = value,
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                ListTile(
                  titleTextStyle: const TextStyle(
                    color: AppColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  title: const Text("Description"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 160,
                        child: Text(
                          alarmDescription,
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 16)
                    ],
                  ),
                  onTap: () {
                    onDesriptionPressed();
                    descriptionTextController.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: descriptionTextController.text.length,
                    );
                    setState(() {});
                  },
                )
              ]),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: !isNew
          ? PrimaryButtonWidget(
              foregroundColor:
                  const MaterialStatePropertyAll(AppColors.dangerRedColor),
              onPressed: () => setState(() => onDeleted()),
              child: const Text('DELETE'),
            )
          : const SizedBox(),
    );
  }
}
