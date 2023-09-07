import 'package:clock/features/src/components/view.dart';
import 'package:flutter/material.dart';

class AlarmClockPage extends StatelessWidget {
  const AlarmClockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            const AppBarWidget(text: 'Alarm clock'),
            const SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 5),
                  CircleClockWidget(),
                  SizedBox(height: 5),
                ],
              ),
            ),
            SliverList.builder(
              itemCount: 10,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                    title: const Text(
                      '18:00',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: const Text(
                      'call to mum',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Switch(value: true, onChanged: (val) {}),
                    onTap: () {}),
              ),
            )

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15),
            //   child: Stack(
            //     children: [
            //       Column(
            //         children: [
            //           CircleClockWidget(),
            //           Expanded(
            //             child: ListView.separated(
            //               shrinkWrap: true,
            //               itemCount: 10,
            //               itemBuilder: (context, index) => Card(
            //                 child: ListTile(
            //                     title: const Text(
            //                       '18:00',
            //                       maxLines: 1,
            //                       overflow: TextOverflow.ellipsis,
            //                     ),
            //                     subtitle: const Text(
            //                       'call to mum',
            //                       maxLines: 1,
            //                       overflow: TextOverflow.ellipsis,
            //                     ),
            //                     trailing: Text('Switch')),
            //               ),
            //               separatorBuilder: (context, index) => const SizedBox(),
            //             ),
            //           )
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
