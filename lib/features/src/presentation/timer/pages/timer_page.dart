import 'package:clock/features/src/presentation/timer/widgets/view.dart';
import 'package:clock/features/src/widgets/view.dart';
import 'package:flutter/material.dart';

TimerController timerController = TimerController();
CircleTimerWidget circleTimerWidget = CircleTimerWidget(
  duration: 10,
  controller: timerController,
);

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  static const String routeName = '/timer';

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  void startStopTimer() {
    if (!timerController.isStarted) {
      timerController.start();
    } else if (timerController.isStarted && !timerController.isPaused) {
      timerController.pause();
    } else {
      timerController.resume();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 162,
            child: CustomScrollView(
              slivers: [
                const AppBarWidget(text: 'Timer'),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        circleTimerWidget,
                        const SizedBox(height: 15),
                      ],
                    ),
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
                    onPressed: () {
                      if (timerController.isPaused) {
                        timerController.reset();
                      }
                    },
                  ),
                  FABButtonWidget(
                    icon: timerController.isRunning
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    onPressed: circleTimerWidget.duration != 0 ||
                            timerController.isCompleted
                        ? () => setState(() {
                              startStopTimer();
                              print(timerController.isCompleted);
                            })
                        : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.audiotrack_rounded),
                    onPressed: () {},
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
