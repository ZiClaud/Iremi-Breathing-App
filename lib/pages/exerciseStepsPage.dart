import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/exercise.dart';

import '../utils/defaultWidget.dart';
import 'exercisePage.dart';

class ExerciseStepsPage extends StatefulWidget {
  MyExercise exercise;

  ExerciseStepsPage({Key? key, required MyExercise this.exercise})
      : super(key: key);

  @override
  State<ExerciseStepsPage> createState() => _ExerciseStepsPageState();
}

class _ExerciseStepsPageState extends State<ExerciseStepsPage> {
  @override
  Widget build(BuildContext context) {
    MyExercise exercise = widget.exercise;
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return DataTable(
            showCheckboxColumn: false,
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Steps',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
                ),
              ),
            ],
            rows: exercise.steps
                .map(((steps) => DataRow(
                        onSelectChanged: (bool) {
                          Navigator.pop(
                            context,
                          );
                        },
                        cells: <DataCell>[
                          DataCell(defaultShowTextFormField(
                              steps, "", Icons.shape_line)),
                        ])))
                .toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
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
