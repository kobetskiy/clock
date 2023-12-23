import 'package:clock/features/src/presentation/stopwatch/widgets/circle_stopwatch_widget.dart';
import 'package:flutter/material.dart';

class LapsListWidget extends StatelessWidget {
  const LapsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: laps.length,
      itemBuilder: (context, index) {
        int reversedIndex = laps.length - 1 - index;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Card(
            margin: const EdgeInsets.all(0),
            child: ListTile(
              title: Text('Lap ${reversedIndex + 1}'),
              trailing: Text(laps[reversedIndex]),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
    );
  }
}
