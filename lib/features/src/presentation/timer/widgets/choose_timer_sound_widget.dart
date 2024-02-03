import 'package:flutter/material.dart';

class ChooseTimerSoundWidget extends StatefulWidget {
  const ChooseTimerSoundWidget({super.key});

  @override
  State<ChooseTimerSoundWidget> createState() => _ChooseTimerSoundWidgetState();
}

enum SingingCharacter { lafayette, jefferson }

class _ChooseTimerSoundWidgetState extends State<ChooseTimerSoundWidget> {
  SingingCharacter? _character = SingingCharacter.lafayette;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      title: const Text("Choose sound for timer"),
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      contentTextStyle: Theme.of(context).textTheme.titleSmall,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile(
            title: const Text('Lafayette'),
            value: SingingCharacter.lafayette,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
          RadioListTile(
            title: const Text('Thomas Jefferson'),
            value: SingingCharacter.jefferson,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text('Apply'),
          onPressed: () {},
        ),
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    );
  }
}
