import 'package:clock/core/ui/colors/colors.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget(
      {super.key, required this.tabIndex, this.onTap});

  final int tabIndex;
  final Function(int)? onTap;

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.barColor,
      elevation: 0,
      unselectedItemColor: AppColors.unselectedItemColor,
      selectedItemColor: AppColors.textColor,
      selectedLabelStyle: const TextStyle(fontSize: 12),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.watch_later_outlined),
          activeIcon: Icon(Icons.watch_later_rounded),
          label: 'Clock',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.stop_circle_outlined),
          activeIcon: Icon(Icons.stop_circle_rounded),
          label: 'Stopwatch',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.timer_outlined),
          activeIcon: Icon(Icons.timer_rounded),
          label: 'Timer',
        ),
      ],
      currentIndex: widget.tabIndex,
      onTap: widget.onTap,
    );
  }
}
