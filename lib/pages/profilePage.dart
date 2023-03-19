import 'package:flutter/material.dart';

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
            defaultTextFormField("Username", user.username, Icons.person),
            defaultTextFormField("Name", user.name, Icons.nest_cam_wired_stand),
            defaultTextFormField("Surname", user.surname!, Icons.surfing),
            defaultTextFormField("Sex", user.sex!, Icons.male),
            defaultTextFormField("Goal", user.goal, Icons.panorama_fish_eye),
            defaultTextFormField("Badges", user.badges, Icons.badge),
            defaultTextFormField(
                "Language", user.language, Icons.laptop_chromebook_outlined),
            defaultTextFormField(
                "Darkmode", user.darkmode, Icons.dark_mode),
            defaultTextFormField(
                "ExerciseHistory", user.exerciseHistory, Icons.book),
            defaultTextFormField("Settings", user.settings, Icons.settings),
          ],
        ));
  }
}
