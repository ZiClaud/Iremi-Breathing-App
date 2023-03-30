/*
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
                      defaultInputDecorator(
                          "Username", user.username, Icons.person),
                      if (user.name.isNotEmpty)
                        defaultInputDecorator(
                            "Name", user.name, Icons.badge_outlined),
                      if (user.sex.isNotEmpty)
                      defaultInputDecorator("Sex", user.sex, Icons.search),
                      if (user.goal.isNotEmpty)
                      defaultInputDecorator(
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
 */

import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/badge.dart';
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
  MyUser? _user;
  List<MyBadge> _badges = [];

  @override
  void initState() {
    super.initState();
    _getUser();
    _getBadges();
  }

  Future<void> _getUser() async {
    MyUser? user = await Getters.getUserDB(context);
    if (user != null) {
      setState(() {
        _user = user;
      });
    }
  }

  Future<void> _getBadges() async {
    List<MyBadge> badge = await Getters.getBadgesDB(context);
    if (badge.isNotEmpty) {
      setState(() {
        _badges = badge;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context, _user),
      body: Column(
        children: [
          Expanded(
            flex: 3, // TODO: Check it it works well on different devices
            child: _showUserWidget(_user),
          ),
          Expanded(
            flex: 1,
            child: _showBadgeWidget(_badges),
          ),
        ],
      ),
    );
  }
}

Widget _showUserWidget(MyUser? user) {
  return user != null
      ? ListView(
          children: [
            defaultInputDecorator("Username", user.username, Icons.person),
            if (user.name.isNotEmpty)
              defaultInputDecorator("Name", user.name, Icons.badge_outlined),
            if (user.sex.isNotEmpty)
              defaultInputDecorator("Sex", user.sex, Icons.search),
            if (user.goal.isNotEmpty)
              defaultInputDecorator("Goal", user.goal, Icons.ads_click),
          ],
        )
      : Center(
          child: defaultText('No user found'),
        );
}

Widget _showBadgeWidget(List<MyBadge?> badges) {
  return (badges.isNotEmpty)
      ? ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: badges.length,
          itemBuilder: (context, index) {
            return defaultBadgeView(
              badges[index]!.getBadge().badgeName,
              badges[index]!.date,
              badges[index]!.getBadge().icon,
            );
          },
        )
      : Center(
          child: defaultText(' '), // 'No badge found'
        );
}

/// APPBAR
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
    ],
  );
}
