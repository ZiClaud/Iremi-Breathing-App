import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/exercises/exercise.dart';

import '../utils/defaultWidget.dart';
import '../utils/myUtils.dart';
import '../utils/theme.dart';
import 'exercisePage.dart';

class ExerciseDetailsPage extends StatefulWidget {
  Exercise exercise;

  ExerciseDetailsPage({Key? key, required Exercise this.exercise})
      : super(key: key);

  @override
  State<ExerciseDetailsPage> createState() => _ExerciseDetailsPageState();
}

class _ExerciseDetailsPageState extends State<ExerciseDetailsPage> {
  @override
  Widget build(BuildContext context) {
    Exercise exercise = widget.exercise;
    return Scaffold(
        appBar: AppBar(
          title: Text(exercise.name),
          backgroundColor: myBluLight,
        ),
        body: ListView(
          children: [
            defaultTextFormField(
                "Name", exercise.name, Icons.keyboard_double_arrow_up),
            defaultTextFormField(
                "Description", exercise.description, Icons.description),
            defaultTextFormField("notes", exercise.notes, Icons.note),
            defaultTextFormField("steps", "steps - TODO", Icons.select_all),
            defaultTextFormField("Inhale, hold, exhale, hold",
                getDurationString(exercise), Icons.book),
            defaultTextFormField(
                "Times", "${exercise.times}", Icons.repeat),
            defaultTextFormField(
                "Duration of exercise", getTimeString(exercise), Icons.timelapse_sharp),
            OutlinedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExercisePage(exercise: exercise),
                  ),
                )
              },
              child: Text("Start"),
              style: defaultButtonStyle(),
            )
          ],
        ));
  }
}
