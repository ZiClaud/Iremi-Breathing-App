import 'package:flutter/material.dart';
import 'package:iremibreathingapp/utils/theme.dart';

AppBar defaultAppBar(String title) {
  return AppBar(
    title: Text(title),
    backgroundColor: myBluLight,
  );
}


class FourStageAnimation extends StatefulWidget {
  final Duration durationA;
  final Duration durationB;
  final Duration durationC;
  final Duration durationD;

  FourStageAnimation({
    required this.durationA,
    required this.durationB,
    required this.durationC,
    required this.durationD,
  });

  @override
  _FourStageAnimationState createState() => _FourStageAnimationState();
}

class _FourStageAnimationState extends State<FourStageAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Size> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.durationA +
          widget.durationB +
          widget.durationC +
          widget.durationD,
    );
    _animation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<Size>(begin: Size.zero, end: Size.square(100)),
        weight: widget.durationA.inMilliseconds.toDouble() /
            _controller.duration!.inMilliseconds.toDouble(),
      ),
      TweenSequenceItem(
        tween: Tween<Size>(begin: Size.square(100), end: Size.square(100)),
        weight: widget.durationB.inMilliseconds.toDouble() /
            _controller.duration!.inMilliseconds.toDouble(),
      ),
      TweenSequenceItem(
        tween: Tween<Size>(begin: Size.square(100), end: Size.zero),
        weight: widget.durationC.inMilliseconds.toDouble() /
            _controller.duration!.inMilliseconds.toDouble(),
      ),
      TweenSequenceItem(
        tween: Tween<Size>(begin: Size.zero, end: Size.zero),
        weight: widget.durationD.inMilliseconds.toDouble() /
            _controller.duration!.inMilliseconds.toDouble(),
      ),
    ]).animate(_controller);
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
      child: AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget? child) {
          return Container(
            width: _animation.value.width,
            height: _animation.value.height,
            decoration: BoxDecoration(
              color: myBluLight,
              shape: BoxShape.circle,
            ),
          );
        },
      ),
    );
  }
}
