import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/exercise.dart';
import 'package:iremibreathingapp/pages/exerciseStepsPage.dart';

import '../utils/defaultWidget.dart';
import '../utils/myUtils.dart';
import '../utils/theme.dart';
import 'exercisePage.dart';

class ExerciseDetailsPage extends StatefulWidget {
  MyExercise exercise;

  ExerciseDetailsPage({Key? key, required MyExercise this.exercise})
      : super(key: key);

  @override
  State<ExerciseDetailsPage> createState() => _ExerciseDetailsPageState();
}

class _ExerciseDetailsPageState extends State<ExerciseDetailsPage> {
  @override
  Widget build(BuildContext context) {
    MyExercise exercise = widget.exercise;
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
        backgroundColor: myBluLight,
      ),
      body: ListView(
        children: [
          defaultShowTextFormField(
              "Name", exercise.name, Icons.keyboard_double_arrow_up),
          defaultShowTextFormField(
              "Description", exercise.description, Icons.description),
          defaultShowTextFormField("notes", exercise.notes, Icons.note),
          defaultShowTextFormField("Inhale, hold, exhale, hold",
              getDurationString(exercise), Icons.book),
          defaultShowTextFormField("Times", "${exercise.times}", Icons.repeat),
          defaultShowTextFormField("Duration of exercise",
              getTimeString(exercise), Icons.timelapse_sharp),
          defaultOutlinedButton(
              child: defaultText("Steps"),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExerciseStepsPage(exercise: exercise),
                    ),
                  ))
        ],
      ),
      floatingActionButton: defaultFloatingActionButton(
        icon: Icons.play_arrow,
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExercisePage(exercise: exercise),
            ),
          )
        },
      ),
    );
  }
}
