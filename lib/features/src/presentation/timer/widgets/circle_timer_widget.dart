import 'package:flutter/material.dart';
import 'circle_timer_painter_widget.dart';

class CircleTimerWidget extends StatefulWidget {
  final VoidCallback? onComplete;
  final VoidCallback? onStart;
  final int duration;
  final int initialDuration;
  final bool autoStart;
  final CountDownController? controller;

  const CircleTimerWidget({
    super.key,
    required this.duration,
    this.initialDuration = 0,
    this.onComplete,
    this.onStart,
    this.controller,
    this.autoStart = false,
  }) : assert(initialDuration <= duration);

  @override
  CircleTimerWidgetState createState() => CircleTimerWidgetState();
}

class CircleTimerWidgetState extends State<CircleTimerWidget>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _countDownAnimation;
  CountDownController? countDownController;

  String get time {
    String timeStamp = "";
    if (!widget.autoStart && !countDownController!.isStarted) {
      timeStamp = _getTime(Duration(seconds: widget.duration));
    } else {
      Duration? duration = _controller!.duration! * _controller!.value;

      timeStamp = _getTime(duration);
    }

    return timeStamp;
  }

  void _setAnimation() {
    if (widget.autoStart) {
      _controller!.reverse(from: 1);
    }
  }

  void _setAnimationDirection() {
    _countDownAnimation = Tween<double>(begin: 0, end: 1).animate(_controller!);
  }

  void _setController() {
    countDownController?._state = this;
    countDownController?._initialDuration = widget.initialDuration;
    countDownController?._duration = widget.duration;
    countDownController?.isStarted = widget.autoStart;

    if (widget.initialDuration > 0 && widget.autoStart) {
      _controller?.value = 1 - (widget.initialDuration / widget.duration);

      countDownController?.start();
    }
  }

  String _getTime(Duration duration) {
    return '${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
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
          _onComplete();
          break;
      }
    });

    _setAnimation();
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
            return Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: CustomPaint(
                    painter: CustomTimerPainter(
                        animation: _countDownAnimation ?? _controller),
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(fontSize: 40, color: Colors.black87),
                ),
              ],
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
  CircleTimerWidgetState? _state;
  bool isStarted = false, isPaused = false, isRunning = false;
  int? _initialDuration, _duration;

  void start() {
    if (_state != null && _state?._controller != null) {
      _state?._controller?.reverse(
          from:
              _initialDuration == 0 ? 1 : 1 - (_initialDuration! / _duration!));

      isStarted = true;
      isPaused = false;
      isRunning = true;
    }
  }

  void pause() {
    if (_state != null && _state?._controller != null) {
      _state?._controller?.stop(canceled: false);
      isPaused = true;
      isRunning = false;
    }
  }

  void resume() {
    if (_state != null && _state?._controller != null) {
      _state?._controller?.reverse(from: _state!._controller!.value);

      isPaused = false;
      isRunning = true;
    }
  }

  void reset() {
    if (_state != null && _state?._controller != null) {
      _state?._controller?.reset();
      isStarted = _state?.widget.autoStart ?? false;
      isPaused = false;
      isRunning = false;
    }
  }
}
