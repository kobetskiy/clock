import 'package:clock/features/src/models/view.dart';
import 'package:clock/features/src/presentation/stopwatch/widgets/view.dart';
import 'package:clock/features/src/widgets/view.dart';
import 'package:flutter/material.dart';

AlarmClockData db = AlarmClockData();
const CircleStopwatchWidget circleStopwatchWidget = CircleStopwatchWidget();

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
                const SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(height: 25),
                        circleStopwatchWidget,
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
                LapsListWidget(),
                // Builder(builder: (context) {
                //   return const LapsListWidget(
                //     circleStopwatchWidget: circleStopwatchWidget,
                //   );
                // })
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
                    onPressed: !circleStopwatchWidget.isRunning
                        ? () => setState(() => circleStopwatchWidget.reset)
                        : null,
                  ),
                  FABButtonWidget(
                    icon: circleStopwatchWidget.isRunning
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    onPressed: circleStopwatchWidget.isRunning
                        ? () => setState(() => circleStopwatchWidget.start)
                        : () => setState(() => circleStopwatchWidget.stop),
                  ),
                  IconButton(
                    icon: const Icon(Icons.timer_outlined),
                    onPressed: circleStopwatchWidget.isRunning
                        ? () => setState(() => circleStopwatchWidget.addLap)
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
