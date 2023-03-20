import 'package:flutter/material.dart';

import '../utils/defaultWidget.dart';

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
      body: ListView(
        children: [
          defaultEditTextFormField("Name", Icons.keyboard_double_arrow_up),
          defaultEditTextFormField("Description", Icons.description),
          defaultEditTextFormField("Notes", Icons.note),
          defaultEditTextFormField("Steps", Icons.select_all),
          defaultEditTextFormField("InhaleDuration", Icons.circle),
          defaultEditTextFormField("HoldMiddleDuration", Icons.change_circle),
          defaultEditTextFormField("ExhaleDuration", Icons.circle_outlined),
          defaultEditTextFormField(
              "HoldEndDuration", Icons.change_circle_outlined),
          defaultEditTextFormField("Times", Icons.repeat),
        ],
      ),
      floatingActionButton: defaultFloatingActionButton(
        icon: Icons.navigate_next,
        onPressed: () => {
          null //TODO: Change
        },
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:iremibreathingapp/pages/settingsPage.dart';

import '../basics/user.dart';
import '../database/getters.dart';
import '../utils/defaultWidget.dart';
import '../utils/theme.dart';

class UserPage extends StatefulWidget {
  MyUser user = Getters.getUser();

  UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    MyUser user = widget.user;
    return Scaffold(
        appBar: AppBar(
            title: const Text("Profile"),
            backgroundColor: myBluLight,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.edit,
                ),
                onPressed: () {
                  null; // TODO
                },
              ),
            ]),

  }
}

 */