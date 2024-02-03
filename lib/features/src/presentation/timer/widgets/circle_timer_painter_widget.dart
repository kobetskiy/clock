import 'package:flutter/material.dart';
import 'dart:math';

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({required this.animation}) : super(repaint: animation);

  final Animation<double>? animation;

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

    Paint paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    paint.shader = LinearGradient(colors: [
      Colors.blue.shade900,
      Colors.blue.shade400,
    ]).createShader(Offset.zero & size);

    double progress = (animation!.value) * 2 * pi;
    double startAngle = pi * 1.5;

        canvas.drawArc(
      const Offset(10, 10) & Size(size.width - 20, size.height - 20),
      startAngle,
      progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomTimerPainter oldDelegate) {
    return animation!.value != oldDelegate.animation!.value;
  }
}
