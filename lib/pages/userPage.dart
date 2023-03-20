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
        body: ListView(
          children: [
            defaultShowTextFormField("Username", user.username, Icons.person),
            defaultShowTextFormField("Name", user.name, Icons.nest_cam_wired_stand),
            defaultShowTextFormField("Surname", user.surname!, Icons.surfing),
            defaultShowTextFormField("Sex", user.sex!, Icons.male),
            defaultShowTextFormField("Goal", user.goal, Icons.circle_outlined),
            defaultShowTextFormField("Badges", user.badges, Icons.badge),
            defaultShowTextFormField(
                "ExerciseHistory", user.exerciseHistory, Icons.book),
            OutlinedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                )
              },
              child: Text("Settings"),
              style: defaultButtonStyle(),
            )
          ],
        ));
  }
}
