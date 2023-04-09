import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/exercise.dart';
import 'package:iremibreathingapp/basics/exercise_history.dart';
import 'package:iremibreathingapp/database/database.dart';

import '../basics/badge.dart';
import '../utils/default_widgets.dart';
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
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(exercise.name),
        ),
        body: _FourStageAnimation(exercise: exercise),
      ),
    );
  }

  Future<bool> onWillPop() {
    widget.exercise.stopTTS();

    Navigator.pop(context);
    return Future.value(true);
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

    widget.exercise.startTTS();

    _controller = AnimationController(
      vsync: this,
      duration: widget.exercise.getInhaleDuration() +
          widget.exercise.getHoldMiddleDuration() +
          widget.exercise.getExhaleDuration() +
          widget.exercise.getHoldEndDuration(),
    );

    _animation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<Size>(
            begin: Size.zero, end: Size.square(defaultCircleSize())),
        weight: widget.exercise.getInhaleDuration().inMilliseconds.toDouble() /
            _controller.duration!.inMilliseconds.toDouble(),
      ),
      TweenSequenceItem(
        tween: Tween<Size>(
            begin: Size.square(defaultCircleSize()),
            end: Size.square(defaultCircleSize())),
        weight:
            widget.exercise.getHoldMiddleDuration().inMilliseconds.toDouble() /
                _controller.duration!.inMilliseconds.toDouble(),
      ),
      TweenSequenceItem(
        tween: Tween<Size>(
            begin: Size.square(defaultCircleSize()), end: Size.zero),
        weight: widget.exercise.getExhaleDuration().inMilliseconds.toDouble() /
            _controller.duration!.inMilliseconds.toDouble(),
      ),
      TweenSequenceItem(
        tween: Tween<Size>(begin: Size.zero, end: Size.zero),
        weight: widget.exercise.getHoldEndDuration().inMilliseconds.toDouble() /
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
        _finishExercise(context);
      }
    }
  }

  void _finishExercise(BuildContext context) {
    DBExerciseHistory().createExerciseHistory(ExerciseHistory(
      exerciseDurationSeconds: widget.exercise.getTime().inSeconds,
      dateTime: DateTime.now(),
    ));

    Achievement.addAchievement(PossibleBadges.airApprentice, context);
    Achievement.checkExerciseHistoryAchievement(context);
    if (widget.exercise.getTime().inMinutes >= 5) {
      Achievement.addAchievement(PossibleBadges.deepBreather, context);
    }

    widget.exercise.stopTTS();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Center(
            child: Container(
              width: defaultCircleSize(),
              height: defaultCircleSize(),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: myBluNeutral,
              ),
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget? child) {
                return Container(
                  width: _animation.value.width,
                  height: _animation.value.height,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: myBluLightDark(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
