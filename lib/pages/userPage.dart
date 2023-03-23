import 'package:flutter/material.dart';
import 'package:iremibreathingapp/pages/registerPageDB.dart';
import 'package:iremibreathingapp/pages/settingsPage.dart';

import '../basics/user.dart';
import '../database/getters.dart';
import '../utils/defaultWidget.dart';

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
                      if (user.name.isNotEmpty)
                        defaultShowTextFormField(
                            "Name", user.name, Icons.badge_outlined),
                      if (user.sex.isNotEmpty)
                      defaultShowTextFormField("Sex", user.sex, Icons.search),
                      if (user.goal.isNotEmpty)
                      defaultShowTextFormField(
                          "Goal", user.goal, Icons.ads_click),
                    ],
                  ));
            } else {
              return Scaffold(
                appBar: _appBar(context, null),
                body: Center(child: defaultText('No user found')),
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
                builder: (context) => SettingsPage(user: user),
              ),
            );
          },
        ),
      ]);
}
