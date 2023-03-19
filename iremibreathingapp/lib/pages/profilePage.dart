import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/exercises/exercise.dart';

import '../basics/user.dart';
import '../database/getters.dart';
import '../utils/dfaultWidget.dart';
import '../utils/theme.dart';

class ProfilePage extends StatefulWidget {
  MyUser user = Getters.getUser();

  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    MyUser user = widget.user;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          backgroundColor: myBluLight,
        ),
        body: ListView(
          children: [
            Text(user.username),
            Text(user.name),
            Text(user.surname!),
            Text(user.sex!),
            Text(user.exerciseHistory),
            Text(user.goal),
            Text(user.settings),
            Text(user.badges),
          ],
        ));
  }
}
