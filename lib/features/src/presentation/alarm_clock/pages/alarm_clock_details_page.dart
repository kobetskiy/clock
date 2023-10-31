import 'package:clock/core/ui/colors/colors.dart';
import 'package:clock/features/src/presentation/alarm_clock/widgets/view.dart';
import 'package:clock/features/src/widgets/view.dart';
import 'package:flutter/material.dart';

class AlarmClockDetailsPage extends StatefulWidget {
  const AlarmClockDetailsPage({super.key});

  @override
  State<AlarmClockDetailsPage> createState() => _AlarmClockDetailsPageState();
}

class _AlarmClockDetailsPageState extends State<AlarmClockDetailsPage> {
  TextEditingController descriptionTextController =
      TextEditingController(text: 'Alarm');

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

  void onDeleted() {
    setState(() {
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
                // ! delete
                Navigator.of(context, rootNavigator: true)
                    .popUntil(ModalRoute.withName('/'));
              },
              child: const Text('DELETE'),
            ),
          ],
        ),
      );
    });
  }

  void onBackButtonPressed() {
    setState(() {
      alertDialog(
        title: 'Save alarm?',
        buttons: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButtonWidget(
              isOutlined: true,
              width: 50,
              height: 12,
              onPressed: () => Navigator.maybePop(context),
              child: const Text('NO'),
            ),
            const SizedBox(width: 10),
            PrimaryButtonWidget(
              width: 50,
              height: 12,
              onPressed: () {
                // ! save alarm
                Navigator.of(context, rootNavigator: true)
                    .popUntil(ModalRoute.withName('/'));
              },
              child: const Text('YES'),
            ),
          ],
        ),
      );
    });
  }

  void onDesriptionPressed() {
    setState(() {
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
              onPressed: () => Navigator.maybePop(context),
              child: const Text('CANCEL'),
            ),
            const SizedBox(width: 10),
            PrimaryButtonWidget(
              width: 50,
              height: 12,
              onPressed: () {
                // ! save new description
                setState(() {});
                Navigator.maybePop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            AppBarWidget(
              text: 'New alarm',
              leading: IconButton(
                onPressed: onBackButtonPressed,
                icon: const Icon(
                  Icons.arrow_back_rounded,
                ),
              ),
              action: [
                IconButton(
                  onPressed: () {
                    // ! save alarm
                    Navigator.maybePop(context);
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
                    CustomTimePickerWidget(timeValue: 5, maxValue: 23),
                    CustomTimePickerWidget(timeValue: 5, maxValue: 59),
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
                          descriptionTextController.text,
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
                  },
                )
              ]),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: PrimaryButtonWidget(
        foregroundColor:
            const MaterialStatePropertyAll(AppColors.dangerRedColor),
        onPressed: onDeleted,
        child: const Text('DELETE'),
      ),
    );
  }
}
