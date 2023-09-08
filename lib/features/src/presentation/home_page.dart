import 'package:clock/features/src/widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:clock/features/src/presentation/pages_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = [
    AlarmClockPage(),
    StopwatchPage(),
    TimerPage(),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Theme(
        data: ThemeData(splashColor: Colors.transparent,),
        child: BottomNavigationBarWidget(
          tabIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
