import 'package:flutter/material.dart';

import '../utils/defaultWidget.dart';

class ExerciseAddPage extends StatefulWidget {
  const ExerciseAddPage({Key? key}) : super(key: key);

  @override
  State<ExerciseAddPage> createState() => _ExerciseAddPageState();
}

class _ExerciseAddPageState extends State<ExerciseAddPage> {
  bool _showComplex = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add custom exercise"),
        actions: [
          IconButton(
            icon: const Icon(Icons.lightbulb_circle),
            onPressed: () {
              setState(() {
                _showComplex = !_showComplex;
              });
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          defaultEditTextFormField("Name", Icons.keyboard_double_arrow_up),
          defaultEditTextFormField("Description", Icons.description),
          defaultEditTextFormField("Notes", Icons.note),
          defaultEditTextFormField("Steps", Icons.square_foot), // TODO
          defaultEditTextFormField("Times", Icons.incomplete_circle),
          defaultEditTextFormField("InhaleDuration", Icons.circle),
          if (_showComplex)
            defaultEditTextFormField("InhaleDuration (ms)", Icons.circle), // TODO: Make icon smaller
          defaultEditTextFormField("HoldMiddleDuration", Icons.change_circle),
          if (_showComplex)
            defaultEditTextFormField(
                "HoldMiddleDuration (ms)", Icons.change_circle), // TODO: Make icon smaller
          defaultEditTextFormField("ExhaleDuration", Icons.circle_outlined),
          if (_showComplex)
            defaultEditTextFormField(
                "ExhaleDuration (ms)", Icons.circle_outlined), // TODO: Make icon smaller
          defaultEditTextFormField(
              "HoldEndDuration", Icons.change_circle_outlined),
          if (_showComplex)
            defaultEditTextFormField(
                "HoldEndDuration (ms)", Icons.change_circle_outlined), // TODO: Make icon smaller
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigate_next),
        onPressed: () => {
          null //TODO: Change
        },
      ),
    );
  }
}
