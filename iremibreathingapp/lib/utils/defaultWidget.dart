import 'package:flutter/material.dart';
import 'package:iremibreathingapp/utils/theme.dart';

AppBar defaultAppBar(String title) {
  return AppBar(
    title: Text(title),
    backgroundColor: myBluLight,
  );
}

TextFormField defaultTextFormField(String lable, String text, IconData icon) {
  return TextFormField(
    enabled: false,
    initialValue: text,
    decoration: InputDecoration(
        label: Text(lable),
        prefixIcon: Icon(
          icon,
          color: myBluLight,
        ),
        labelStyle: TextStyle(fontSize: 15, color: Colors.black)),
  );
}

ButtonStyle defaultButtonStyle() {
  return ButtonStyle();
}

class FourStageAnimation extends StatefulWidget {
  final Duration durationA;
  final Duration durationB;
  final Duration durationC;
  final Duration durationD;
  final int times;

  FourStageAnimation({
    required this.durationA,
    required this.durationB,
    required this.durationC,
    required this.durationD,
    required this.times,
  });

  @override
  _FourStageAnimationState createState() => _FourStageAnimationState();
}

class _FourStageAnimationState extends State<FourStageAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Size> _animation;
  int _counter = 0;

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
        tween: Tween<Size>(begin: Size.zero, end: Size.square(200)),
        weight: widget.durationA.inMilliseconds.toDouble() /
            _controller.duration!.inMilliseconds.toDouble(),
      ),
      TweenSequenceItem(
        tween: Tween<Size>(begin: Size.square(200), end: Size.square(200)),
        weight: widget.durationB.inMilliseconds.toDouble() /
            _controller.duration!.inMilliseconds.toDouble(),
      ),
      TweenSequenceItem(
        tween: Tween<Size>(begin: Size.square(200), end: Size.zero),
        weight: widget.durationC.inMilliseconds.toDouble() /
            _controller.duration!.inMilliseconds.toDouble(),
      ),
      TweenSequenceItem(
        tween: Tween<Size>(begin: Size.zero, end: Size.zero),
        weight: widget.durationD.inMilliseconds.toDouble() /
            _controller.duration!.inMilliseconds.toDouble(),
      ),
    ]).animate(_controller);
/*
TODO: Make it work
    _controller.addStatusListener((status) {
      print(status);
      if (status == AnimationStatus.completed) {
        if (_counter < widget.times) {
          _counter++;
          _controller.repeat();
        } else {
          _controller.stop();
        }
      }
    });
*/
    _controller.repeat();
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
