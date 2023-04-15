import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/exercise.dart';
import 'package:iremibreathingapp/basics/exercise_history.dart';
import 'package:iremibreathingapp/database/database.dart';

import '../basics/badge.dart';
import '../utils/default_widgets.dart';
import '../utils/theme.dart';

class ExercisePage extends StatefulWidget {
  MyExercise exercise;

  ExercisePage({Key? key, required this.exercise}) : super(key: key);

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
          title: Text(exercise.name()),
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

  const _FourStageAnimation({required this.exercise});

  @override
  _FourStageAnimationState createState() => _FourStageAnimationState();
}

class _FourStageAnimationState extends State<_FourStageAnimation>
    with SingleTickerProviderStateMixin {
  // TODO: Make it work for complex ex too
  late AnimationController _controller;
  late Animation<Size> _animation;

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

    _animation =
        getAnimation(widget.exercise, _controller).animate(_controller);

    // Start the loop
    _loopAnimation(_controller, widget.exercise, context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getBall(_animation);
  }
}

Widget getBall(Animation<Size> animation) {
  return Center(
    child: Stack(
      children: [
        Center(
          child: Container(
            width: defaultCircleSize(),
            height: defaultCircleSize(),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: myBluNeutral,
            ),
          ),
        ),
        Center(
          child: AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget? child) {
              return Container(
                width: animation.value.width,
                height: animation.value.height,
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

TweenSequence<Size> getAnimation(MyExercise exercise,
    AnimationController controller) {
  return TweenSequence([
    TweenSequenceItem(
      tween:
      Tween<Size>(begin: Size.zero, end: Size.square(defaultCircleSize())),
      weight: exercise
          .getInhaleDuration()
          .inMilliseconds
          .toDouble() /
          controller.duration!.inMilliseconds.toDouble(),
    ),
    TweenSequenceItem(
      tween: Tween<Size>(
          begin: Size.square(defaultCircleSize()),
          end: Size.square(defaultCircleSize())),
      weight: exercise
          .getHoldMiddleDuration()
          .inMilliseconds
          .toDouble() /
          controller.duration!.inMilliseconds.toDouble(),
    ),
    TweenSequenceItem(
      tween:
      Tween<Size>(begin: Size.square(defaultCircleSize()), end: Size.zero),
      weight: exercise
          .getExhaleDuration()
          .inMilliseconds
          .toDouble() /
          controller.duration!.inMilliseconds.toDouble(),
    ),
    TweenSequenceItem(
      tween: Tween<Size>(begin: Size.zero, end: Size.zero),
      weight: exercise
          .getHoldEndDuration()
          .inMilliseconds
          .toDouble() /
          controller.duration!.inMilliseconds.toDouble(),
    ),
  ]);
}

void _loopAnimation(AnimationController controller, MyExercise exercise,
    BuildContext context) async {
  int counter = 0;
  while (counter < exercise.times()) {
    // Run the animation once
    await controller
        .forward()
        .orCancel;

    // Increment the counter
    counter++;

    // Reset the animation if it's not the last iteration
    if (counter < exercise.times()) {
      controller.reset();
    } else {
      _finishExercise(exercise, context);
    }
  }
}

void _finishExercise(MyExercise exercise, BuildContext context) {
  DBExerciseHistory().createExerciseHistory(ExerciseHistory(
    exerciseDurationSeconds: exercise
        .getTime()
        .inSeconds,
    dateTime: DateTime.now(),
  ));

  Achievement.addAchievement(PossibleBadges.airApprentice, context);
  Achievement.checkExerciseHistoryAchievement(context);
  if (exercise
      .getTime()
      .inMinutes >= 5) {
    Achievement.addAchievement(PossibleBadges.deepBreather, context);
  }

  exercise.stopTTS();
  Navigator.pop(context);
}
