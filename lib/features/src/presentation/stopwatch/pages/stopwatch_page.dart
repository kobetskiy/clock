import 'package:clock/features/src/models/view.dart';
import 'package:clock/features/src/presentation/stopwatch/widgets/circle_stopwatch_widget.dart';
import 'package:clock/features/src/widgets/view.dart';
import 'package:flutter/material.dart';

AlarmClockData db = AlarmClockData();
StopwatchController stopwatchController = StopwatchController();
CircleStopwatchWidget circleStopwatchWidget = CircleStopwatchWidget(
  controller: stopwatchController,
);

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  static const String routeName = '/stopwatch';

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 162,
            child: CustomScrollView(
              slivers: [
                const AppBarWidget(text: 'Stopwatch'),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        circleStopwatchWidget,
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
                SliverList.separated(
                  itemCount: stopwatchController.lapsList.length,
                  itemBuilder: (context, index) {
                    int reversedIndex =
                        stopwatchController.lapsList.length - 1 - index;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Card(
                        margin: const EdgeInsets.all(0),
                        child: ListTile(
                          title: Text('Lap ${reversedIndex + 1}'),
                          trailing:
                              Text(stopwatchController.lapsList[reversedIndex]),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.rotate_left_rounded),
                    onPressed: !stopwatchController.isRunning
                        ? () => setState(() => stopwatchController.reset())
                        : null,
                  ),
                  FABButtonWidget(
                    icon: stopwatchController.isRunning
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    onPressed: stopwatchController.isRunning
                        ? () => setState(() => stopwatchController.start())
                        : () => setState(() => stopwatchController.stop()),
                  ),
                  IconButton(
                    icon: const Icon(Icons.timer_outlined),
                    onPressed: stopwatchController.isRunning
                        ? () => setState(() => stopwatchController.addLap())
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
