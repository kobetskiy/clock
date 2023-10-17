import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class CircleClockWidget extends StatefulWidget {
  const CircleClockWidget({super.key});

  @override
  State<CircleClockWidget> createState() => _CircleClockWidgetState();
}

class _CircleClockWidgetState extends State<CircleClockWidget> {
  String formatTime() {
    String hour = DateTime.now().hour.toString();
    String minute = DateTime.now().minute.toString();
    if (hour.length < 2) {
      hour = '0$hour';
    }
    if (minute.length < 2) {
      minute = '0$minute';
    }
    return '$hour:$minute';
  }

  late String time = formatTime();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 1000), (_) {
      setState(() {
        time = formatTime();
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 250,
          height: 250,
          child: CustomPaint(
            painter: CustomCircle(),
          ),
        ),
        Text(
          time,
          style: const TextStyle(fontSize: 48, color: Colors.black87),
        )
      ],
    );
  }
}

class CustomCircle extends CustomPainter {
  DateTime time = DateTime.now();

  late double percents = 1 / 0.6 * time.second / 100;

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint();
    bgPaint.color = Colors.grey.shade400;
    canvas.drawOval(Offset.zero & size, bgPaint);

    final borderPaint = Paint();
    borderPaint.color = Colors.grey.shade800;
    borderPaint.style = PaintingStyle.stroke;
    borderPaint.strokeWidth = 20;
    canvas.drawArc(
      const Offset(10, 10) & Size(size.width - 20, size.height - 20),
      -pi / 2,
      pi * 2,
      false,
      borderPaint,
    );

    final fillPaint = Paint();
    fillPaint.shader = LinearGradient(
      colors: [Colors.blue.shade900, Colors.blue.shade400],
    ).createShader(Offset.zero & size);
    fillPaint.strokeCap = StrokeCap.round;
    fillPaint.style = PaintingStyle.stroke;
    fillPaint.strokeWidth = 20;
    canvas.drawArc(
      const Offset(10, 10) & Size(size.width - 20, size.height - 20),
      -pi / 2,
      pi * 2 * percents,
      false,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
