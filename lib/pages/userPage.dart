import 'package:flutter/material.dart';
import 'package:iremibreathingapp/pages/settingsPage.dart';

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
                  appBar: _appBar(context),
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
                      defaultShowTextFormField(
                          "Badges", user.badges, Icons.badge),
                    ],
                  ));
            } else {
              return Scaffold(
                appBar: _appBar(context),
                body: defaultErrorText('No user found'),
              );
            }
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

AppBar _appBar(context){
  return AppBar(
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
        IconButton(
          icon: const Icon(
            Icons.settings,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(),
              ),
            );
          },
        ),
      ]);
}