import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class CircleStopwatchWidget extends StatefulWidget {
  const CircleStopwatchWidget({super.key});

  void get startStop => _CircleStopwatchWidgetState().startStopStopwatch();
  void get reset => _CircleStopwatchWidgetState().resetStopwatch();
  void get addLap => _CircleStopwatchWidgetState().addLap();
  List<String> get getLaps => _CircleStopwatchWidgetState().getLaps();

  @override
  State<CircleStopwatchWidget> createState() => _CircleStopwatchWidgetState();
}

late Stopwatch stopwatch;
late Stopwatch circleStopwatch;
late Timer timer;
List<String> laps = [];
late bool hasHours;

String circleMillisecond() {
  String circleMillisecond = circleStopwatch.elapsed.inMilliseconds.toString();
  if (circleStopwatch.isRunning) {
    if (int.parse(circleMillisecond) >= 60000) {
      circleStopwatch.reset();
    }
  }
  return circleMillisecond;
}

String formattedText() {
  int milli = stopwatch.elapsed.inMilliseconds;
  String milliseconds =
      (milli % 1000).toString().padRight(2, "0").substring(0, 2);
  String seconds = ((milli ~/ 1000) % 60).toString().padLeft(2, "0");
  String minutes = ((milli ~/ 1000) ~/ 60).toString().padLeft(2, "0");
  String hours = ((milli ~/ 1000) ~/ 3600).toString().padLeft(2, "0");

  hours == '00' ? hasHours = true : hasHours = false;

  return hours == '00'
      ? "$minutes:$seconds.$milliseconds"
      : "$hours:$minutes:$seconds.$milliseconds";
}

class _CircleStopwatchWidgetState extends State<CircleStopwatchWidget> {
  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();
    circleStopwatch = Stopwatch();
    hasHours = false;
    timer = Timer.periodic(const Duration(milliseconds: 30), (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startStopStopwatch() {
    if (stopwatch.isRunning) {
      circleStopwatch.stop();
      stopwatch.stop();
    } else {
      circleStopwatch.start();
      stopwatch.start();
    }
  }

  void resetStopwatch() {
    if (!stopwatch.isRunning) {
      stopwatch.reset();
      circleStopwatch.reset();
      laps.clear();
    }
  }

  void addLap() {
    if (stopwatch.isRunning) {
      laps.add(formattedText());
    }
  }

  List<String> getLaps() {
    return laps;
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
          formattedText(),
          style: TextStyle(fontSize: hasHours ? 40 : 32, color: Colors.black87),
        ),
      ],
    );
  }
}

class CustomCircle extends CustomPainter {
  late double percents = 100 / 60000 * int.parse(circleMillisecond()) / 100;

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