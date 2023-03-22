import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/exercise.dart';
import 'package:iremibreathingapp/pages/exerciseAddPage.dart';
import 'package:iremibreathingapp/pages/userPage.dart';

import '../database/getters.dart';
import '../utils/myUtils.dart';
import '../utils/theme.dart';
import 'exerciseDetailsPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    List<MyExercise> exercises = Getters.getExercises();
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Welcome to Iremi"),
          backgroundColor: myBluLight,
          actions: [
            /*
            IconButton(
              icon: const Icon(
                Icons.developer_mode,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TestDBShowUserPage()));
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.cloud_circle,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TestDBAddUserPage()));
              },
            ),
            */
            IconButton(
              icon: const Icon(
                Icons.add_circle,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ExerciseAddPage()));
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.account_circle,
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
