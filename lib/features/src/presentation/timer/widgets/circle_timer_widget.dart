import 'package:flutter/material.dart';
import 'dart:math';

class CircularCountDownTimer extends StatefulWidget {
  final VoidCallback? onComplete;

  /// This Callback will execute when the Countdown Starts.
  final VoidCallback? onStart;

  /// This Callback will execute when the Countdown Changes.
  final ValueChanged<String>? onChange;

  /// Countdown duration in Seconds.
  final int duration;

  /// Countdown initial elapsed Duration in Seconds.
  final int initialDuration;

  /// Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
  final bool isReverse;

  /// Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
  final CountDownController? controller;

  /// Handles the timer start.
  final bool autoStart;

  final Function(Function(Duration duration) defaultFormatterFunction,
      Duration duration)? timeFormatterFunction;

  const CircularCountDownTimer({
    required this.duration,
    this.timeFormatterFunction,
    this.initialDuration = 0,
    this.isReverse = true,
    this.onComplete,
    this.onStart,
    this.onChange,
    super.key,
    this.autoStart = false,
    this.controller,
  }) : assert(initialDuration <= duration);

  @override
  CircularCountDownTimerState createState() => CircularCountDownTimerState();
}

class CircularCountDownTimerState extends State<CircularCountDownTimer>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _countDownAnimation;
  CountDownController? countDownController;

  String get time {
    String timeStamp = "";
    if (widget.isReverse &&
        !widget.autoStart &&
        !countDownController!.isStarted) {
      if (widget.timeFormatterFunction != null) {
        return Function.apply(widget.timeFormatterFunction!,
            [_defaultFormat, Duration(seconds: widget.duration)]).toString();
      } else {
        timeStamp = _defaultFormat(Duration(seconds: widget.duration));
      }
    } else {
      Duration? duration = _controller!.duration! * _controller!.value;
      if (widget.timeFormatterFunction != null) {
        return Function.apply(
                widget.timeFormatterFunction!, [_defaultFormat, duration])
            .toString();
      } else {
        timeStamp = _defaultFormat(duration);
      }
    }
    if (widget.onChange != null) widget.onChange!(timeStamp);

    return timeStamp;
  }

  void _setAnimationDirection() {
    _countDownAnimation = Tween<double>(begin: 0, end: 1).animate(_controller!);
  }

  void _setController() {
    countDownController?._state = this;
    countDownController?._isReverse = widget.isReverse;
    countDownController?._initialDuration = widget.initialDuration;
    countDownController?._duration = widget.duration;
    countDownController?.isStarted = widget.autoStart;

    if (widget.initialDuration > 0 && widget.autoStart) {
      _controller?.value = 1 - (widget.initialDuration / widget.duration);

      countDownController?.start();
    }
  }

  _defaultFormat(Duration duration) {
    String second = (duration.inSeconds % 60).toString().padLeft(2, "0");
    String minute = (duration.inMinutes % 60).toString().padLeft(2, "0");
    String hour = duration.inHours.toString().padLeft(2, "0");

    return "$hour:$minute:$second";
  }

  void _onStart() {
    if (widget.onStart != null) widget.onStart!();
  }

  void _onComplete() {
    if (widget.onComplete != null) widget.onComplete!();
  }

  @override
  void initState() {
    countDownController = widget.controller ?? CountDownController();
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );

    _controller!.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.forward:
          _onStart();
          break;

        case AnimationStatus.reverse:
          _onStart();
          break;

        case AnimationStatus.dismissed:
          _onComplete();
          break;

        case AnimationStatus.completed:
          if (!widget.isReverse) _onComplete();
          break;
      }
    });

    _setAnimationDirection();
    _setController();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 250,
      child: AnimatedBuilder(
          animation: _controller!,
          builder: (context, child) {
            return Align(
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: CustomPaint(
                        painter: CustomTimerPainter(
                            animation: _countDownAnimation ?? _controller),
                      ),
                    ),
                    Align(
                      alignment: FractionalOffset.center,
                      child: Text(
                        time,
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    _controller!.stop();
    _controller!.dispose();
    super.dispose();
  }
}

class CountDownController {
  CircularCountDownTimerState? _state;
  bool? _isReverse;
  bool isStarted = false,
      isPaused = false,
      isResumed = false;
  int? _initialDuration, _duration;

  void start() {
    if (_isReverse != null && _state != null && _state?._controller != null) {
      _state?._controller?.reverse(
          from:
              _initialDuration == 0 ? 1 : 1 - (_initialDuration! / _duration!));

      isStarted = true;
      isPaused = false;
      isResumed = false;
    }
  }

  void pause() {
    if (_state != null && _state?._controller != null) {
      _state?._controller?.stop(canceled: false);
      isPaused = true;
      isResumed = false;
    }
  }

  void resume() {
    if (_isReverse != null && _state != null && _state?._controller != null) {
      if (_isReverse!) {
        _state?._controller?.reverse(from: _state!._controller!.value);
      } else {
        _state?._controller?.forward(from: _state!._controller!.value);
      }
      isResumed = true;
      isPaused = false;
    }
  }

  void reset() {
    if (_state != null) {
      _state!._controller!.duration = Duration.zero;
      isStarted = false;
      isPaused = false;
      isResumed = false;
      _state!.countDownController?.start();
    }
  }
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.animation,
  }) : super(repaint: animation);

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
      pi * 2 * (animation!.value),
      false,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(CustomTimerPainter oldDelegate) {
    return animation!.value != oldDelegate.animation!.value;
  }
}
