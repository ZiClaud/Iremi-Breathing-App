import 'package:flutter/material.dart';

import '../utils/dfaultWidget.dart';
import '../utils/theme.dart';

class addCustomExercise extends StatefulWidget {
  const addCustomExercise({Key? key}) : super(key: key);

  @override
  State<addCustomExercise> createState() => _addCustomExerciseState();
}

class _addCustomExerciseState extends State<addCustomExercise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar("Add custom exercise!"),
      body: Center(child: Text("Page is in WIP!")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          null //TODO: Change
        },
        foregroundColor: myWhite,
        backgroundColor: myBluLight,
        tooltip: 'Next',
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
