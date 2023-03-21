import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/exercises/exercise.dart';

import '../utils/theme.dart';

class ExercisePage extends StatefulWidget {
  MyExercise exercise;

  ExercisePage({Key? key, required MyExercise this.exercise}) : super(key: key);

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  @override
  Widget build(BuildContext context) {
    MyExercise exercise = widget.exercise;
    return Scaffold(
        appBar: AppBar(
          title: Text(exercise.name),
          backgroundColor: myBluLight,
        ),
        body: _FourStageAnimation(exercise: exercise));
  }
}

class _FourStageAnimation extends StatefulWidget {
  final MyExercise exercise;

  _FourStageAnimation({
    required this.exercise,
  });

  @override
  _FourStageAnimationState createState() => _FourStageAnimationState();
}

class _FourStageAnimationState extends State<_FourStageAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Size> _animation;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.exercise.inhaleDuration +
          widget.exercise.holdMiddleDuration +
          widget.exercise.exhaleDuration +
          widget.exercise.holdEndDuration,
    );

    _animation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<Size>(begin: Size.zero, end: Size.square(200)),
        weight: widget.exercise.inhaleDuration.inMilliseconds.toDouble() /
            _controller.duration!.inMilliseconds.toDouble(),
      ),
      TweenSequenceItem(
        tween: Tween<Size>(begin: Size.square(200), end: Size.square(200)),
        weight: widget.exercise.holdMiddleDuration.inMilliseconds.toDouble() /
            _controller.duration!.inMilliseconds.toDouble(),
      ),
      TweenSequenceItem(
        tween: Tween<Size>(begin: Size.square(200), end: Size.zero),
        weight: widget.exercise.exhaleDuration.inMilliseconds.toDouble() /
            _controller.duration!.inMilliseconds.toDouble(),
      ),
      TweenSequenceItem(
        tween: Tween<Size>(begin: Size.zero, end: Size.zero),
        weight: widget.exercise.holdEndDuration.inMilliseconds.toDouble() /
            _controller.duration!.inMilliseconds.toDouble(),
      ),
    ]).animate(_controller);

    // Start the loop
    _loopAnimation();
  }

  void _loopAnimation() async {
    while (_counter < widget.exercise.times) {
      // Run the animation once
      await _controller.forward().orCancel;

      // Increment the counter
      _counter++;

      // Reset the animation if it's not the last iteration
      if (_counter < widget.exercise.times) {
        _controller.reset();
      } else {
        Navigator.pop(context);
      }
    }
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
