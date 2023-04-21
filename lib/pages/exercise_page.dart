import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/complex_exercise.dart';
import 'package:iremibreathingapp/basics/exercise.dart';
import 'package:iremibreathingapp/basics/exercise_history.dart';
import 'package:iremibreathingapp/database/database.dart';

import '../basics/badge.dart';
import '../utils/default_widgets.dart';
import '../utils/theme.dart';
import 'home_page.dart';

class ExercisePage extends StatefulWidget {
 final MyExercise exercise;

  const ExercisePage({Key? key, required this.exercise}) : super(key: key);

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  @override
  Widget build(BuildContext context) {
    MyExercise exercise = widget.exercise;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(exercise.name()),
        ),
        body: _FourStageAnimation(exercise: exercise),
      ),
    );
  }

  Future<bool> _onWillPop() {
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
  late AnimationController _controller;
  late Animation<Size> _animation;
  late MyExercise ex;

  @override
  void initState() {
    super.initState();

    ex = widget.exercise;
    if (ex is ComplexExercise) {
      ex = (ex as ComplexExercise).exercises().first;
      _startAnimation(ex);
    } else {
      _startAnimation(ex);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getBall();
  }

  void _startAnimation(MyExercise ex) {
    ex.startTTS();

    _controller = AnimationController(
      vsync: this,
      duration: ex.getInhaleDuration() +
          ex.getHoldMiddleDuration() +
          ex.getExhaleDuration() +
          ex.getHoldEndDuration(),
    );

    _animation = _getAnimation(ex, _controller).animate(_controller);

    // Start the loop
    if (ex is ComplexExercise) { //TODO: FIX
      _loopAnimation(ex.exercises().first);
    } else {
      _loopAnimation(ex);
    }
  }

  void _startNewAnimation(MyExercise newEx, MyExercise oldEx) {
    oldEx.stopTTS();

    newEx.startTTS();
    _controller.repeat(
        period: newEx.getInhaleDuration() +
            newEx.getHoldMiddleDuration() +
            newEx.getExhaleDuration() +
            newEx.getHoldEndDuration());
    _animation = _getAnimation(newEx, _controller).animate(_controller);
    _loopAnimation(newEx);
  }

  Widget _getBall() {
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

  TweenSequence<Size> _getAnimation(
      MyExercise exercise, AnimationController controller) {
    return TweenSequence([
      TweenSequenceItem(
        tween: Tween<Size>(
            begin: Size.zero, end: Size.square(defaultCircleSize())),
        weight: exercise.getInhaleDuration().inMilliseconds.toDouble() /
            controller.duration!.inMilliseconds.toDouble(),
      ),
      TweenSequenceItem(
        tween: Tween<Size>(
            begin: Size.square(defaultCircleSize()),
            end: Size.square(defaultCircleSize())),
        weight: exercise.getHoldMiddleDuration().inMilliseconds.toDouble() /
            controller.duration!.inMilliseconds.toDouble(),
      ),
      TweenSequenceItem(
        tween: Tween<Size>(
            begin: Size.square(defaultCircleSize()), end: Size.zero),
        weight: exercise.getExhaleDuration().inMilliseconds.toDouble() /
            controller.duration!.inMilliseconds.toDouble(),
      ),
      TweenSequenceItem(
        tween: Tween<Size>(begin: Size.zero, end: Size.zero),
        weight: exercise.getHoldEndDuration().inMilliseconds.toDouble() /
            controller.duration!.inMilliseconds.toDouble(),
      ),
    ]);
  }

  void _loopAnimation(MyExercise ex) async {
    int counter = 0;
    while (counter < ex.times()) {
      // Run the animation once
      await _controller.forward().orCancel;

      // Increment the counter
      counter++;

      // Reset the animation if it's not the last iteration
      if (counter < ex.times()) {
        _controller.reset();
      } else {
        _finishExercise(ex);
      }
    }
  }

  void _finishExercise(MyExercise exDone) {
    MyExercise widgetEx = widget.exercise;
    if (widgetEx is ComplexExercise) {
      widgetEx.exercises().remove(exDone);
      if (widgetEx.exercises().isNotEmpty) {
        _startNewAnimation(widgetEx.exercises().first, exDone);
        return;
      }
    }

    DBExerciseHistory().createExerciseHistory(ExerciseHistory(
      exerciseDurationSeconds: exDone.getTime().inSeconds,
      dateTime: DateTime.now(),
    ));

    Achievement.addAchievement(PossibleBadges.airApprentice, context);
    Achievement.checkExerciseHistoryAchievement(context);
    if (exDone.getTime().inMinutes >= 5) {
      Achievement.addAchievement(PossibleBadges.deepBreather, context);
    }

    exDone.stopTTS();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
      (route) => false,
    );
  }
}
