import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/exercises/exercise.dart';

import '../utils/defaultWidget.dart';
import '../utils/theme.dart';

class ExercisePage extends StatefulWidget {
  Exercise exercise;

  ExercisePage({Key? key, required Exercise this.exercise}) : super(key: key);

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  @override
  Widget build(BuildContext context) {
    Exercise exercise = widget.exercise;
    return Scaffold(
        appBar: AppBar(
          title: Text(exercise.name),
          backgroundColor: myBluLight,
        ),
        body: FourStageAnimation(
          durationA: exercise.inhaleDuration,
          durationB: exercise.holdMiddleDuration,
          durationC: exercise.exhaleDuration,
          durationD: exercise.holdEndDuration,
          times: exercise.times,
        ));
  }
}
