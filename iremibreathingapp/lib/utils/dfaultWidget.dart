import 'package:flutter/material.dart';
import 'package:iremibreathingapp/utils/theme.dart';

AppBar defaultAppBar(String title) {
  return AppBar(
    title: Text(title),
    backgroundColor: myBluLight,
  );
}


class BallAnimation extends StatefulWidget {
  final Duration expansionDuration;
  final Duration holdMiddleDuration;
  final Duration contractionDuration;
  final Duration holdEndDuration;

  BallAnimation({
    required this.expansionDuration,
    required this.holdMiddleDuration,
    required this.contractionDuration,
    required this.holdEndDuration,
  });

  @override
  _BallAnimationState createState() => _BallAnimationState();
}

class _BallAnimationState extends State<BallAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.expansionDuration +
          widget.holdMiddleDuration +
          widget.contractionDuration +
          widget.holdEndDuration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      _controller.drive(CurveTween(
        curve: Interval(
          0.0,
          widget.expansionDuration.inMilliseconds /
              _controller.duration!.inMilliseconds,
          curve: Curves.easeInOut,
        ),
      )).drive(CurveTween(
        curve: Interval(
          (widget.expansionDuration.inMilliseconds + widget.holdMiddleDuration.inMilliseconds) /
              _controller.duration!.inMilliseconds,
          (widget.expansionDuration.inMilliseconds + widget.holdMiddleDuration.inMilliseconds + widget.contractionDuration.inMilliseconds) /
              _controller.duration!.inMilliseconds,
          curve: Curves.easeInOut,
        ),
      )).drive(CurveTween(
        curve: Interval(
          (widget.expansionDuration.inMilliseconds + widget.holdMiddleDuration.inMilliseconds + widget.contractionDuration.inMilliseconds) /
              _controller.duration!.inMilliseconds,
          1.0,
          curve: Curves.easeInOut,
        ),
      )),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size.square(100),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) {
            return CustomPaint(
              painter: BallPainter(
                _animation.value,
                Colors.blue,
                Colors.red,
              ),
            );
          },
        ),
      ),
    );
  }
}

class BallPainter extends CustomPainter {
  final double value;
  final Color color;
  final Color backgroundColor;

  BallPainter(this.value, this.color, this.backgroundColor);

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = backgroundColor;
    final fillPaint = Paint()..color = color;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      backgroundPaint,
    );
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2 * value,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
