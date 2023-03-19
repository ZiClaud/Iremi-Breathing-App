import 'package:flutter/material.dart';
import 'package:iremibreathingapp/exercises/exercise.dart';
import 'package:iremibreathingapp/pages/oldMainPage.dart';
import '../database/getters.dart';
import '../utils/theme.dart';
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
          title: Text("Anagrafica Clienti"),
          backgroundColor: myBluLight,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.add,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const OldMainPage())); // TODO: Change
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.person,
              ),
              onPressed: () {
                // TODO?
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
                  'Nome',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
                ),
              ),
              DataColumn(
                label: Text(
                  'Descrizione',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
                ),
              ),
              DataColumn(
                label: Text(
                  'Time',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
                ),
              ),
              DataColumn(
                label: Text(
                  'N. steps',
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
                                      ExercisePage(exercise: exercise)));
                        },
                        cells: <DataCell>[
                          DataCell(Text(exercise.name)),
                          DataCell(Text(exercise.description)),
                          DataCell(Text("${exercise.getTime().inSeconds}s")),
                          DataCell(Text(exercise.steps.length.toString())),
                        ])))
                .toList(),
          );
        },
      ),
    );
  }
}
