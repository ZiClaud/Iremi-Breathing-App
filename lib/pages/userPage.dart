import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/settings.dart';
import 'package:iremibreathingapp/pages/settingsPage.dart';
import 'package:iremibreathingapp/pages/registerPageDB.dart';
import 'package:iremibreathingapp/pages/old/oldSettingsPageDB.dart';

import '../basics/user.dart';
import '../database/getters.dart';
import '../utils/defaultWidget.dart';
import '../utils/theme.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Getters.getUserDB(context),
        builder: (BuildContext context, AsyncSnapshot<MyUser?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data != null) {
              MyUser user = snapshot.data!;
              return Scaffold(
                  appBar: _appBar(context, user),
                  body: ListView(
                    children: [
                      defaultShowTextFormField(
                          "Username", user.username, Icons.person),
                      defaultShowTextFormField(
                          "Name", user.name, Icons.nest_cam_wired_stand),
                      defaultShowTextFormField(
                          "Surname", user.surname!, Icons.surfing),
                      defaultShowTextFormField("Sex", user.sex!, Icons.male),
                      defaultShowTextFormField(
                          "Goal", user.goal, Icons.circle_outlined),
                    ],
                  ));
            } else {
              return Scaffold(
                appBar: _appBar(context, null),
                body: defaultText('No user found'),
              );
            }
          } else {
            return defaultLoadingScreen();
          }
        });
  }
}

AppBar _appBar(context, MyUser? user) {
  return AppBar(
      title: const Text("Profile"),
      backgroundColor: myBluLight,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.edit,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterPageDB(user: user),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.settings,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(), // TODO: REMOVE NULL
              ),
            );
          },
        ),
      ]);
}
