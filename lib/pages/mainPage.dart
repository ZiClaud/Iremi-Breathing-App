import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/exercises/exercise.dart';
import 'package:iremibreathingapp/pages/addExercisePage.dart';
import 'package:iremibreathingapp/pages/profilePage.dart';
import '../database/getters.dart';
import '../utils/myUtils.dart';
import '../utils/theme.dart';
import 'exerciseDetailsPage.dart';
import 'exercisePage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    List<Exercise> exercises = Getters.getExercises();
    return Scaffold(
      appBar: AppBar(
          title: Text("Welcome to Iremi"),
          backgroundColor: myBluLight,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.add_circle_outline,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const addCustomExercise()));
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.person,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserPage()));
              },
            ),
          ]),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return DataTable(
            showCheckboxColumn: false,
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Exercise',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
                ),
              ),
              DataColumn(
                label: Text(
                  'Duration',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
                ),
              ),
            ],
            rows: exercises
                .map(((exercise) => DataRow(
                        onSelectChanged: (bool) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ExerciseDetailsPage(exercise: exercise),
                            ),
                          );
                        },
                        cells: <DataCell>[
                          DataCell(Text(exercise.name)),
                          DataCell(Text(getTimeString(exercise))),
                        ])))
                .toList(),
          );
        },
      ),
    );
  }
}
