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
  late List<MyBadge?> _badge;

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
    List<MyBadge?> badge = await Getters.getBadgesDB(context);
    if (badge.isNotEmpty) {
      setState(() {
        _badge = badge;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context, _user),
      body: _showUserWidget(_user),
      /*
        Column(
        children: [
          _showUserWidget(context),
          _showBadgeWidget(context), // TODO: FIX THIS
        ],
      ),
      */
    );
  }
}

Widget _showUserWidget(MyUser? _user) {
  return _user != null
      ? ListView(
    children: [
      defaultInputDecorator("Username", _user!.username, Icons.person),
      if (_user!.name.isNotEmpty)
        defaultInputDecorator(
            "Name", _user!.name, Icons.badge_outlined),
      if (_user!.sex.isNotEmpty)
        defaultInputDecorator("Sex", _user!.sex, Icons.search),
      if (_user!.goal.isNotEmpty)
        defaultInputDecorator(
            "Goal", _user!.goal, Icons.ads_click),
    ],
  )
      : Center(
    child: defaultText('No user found'),
  );
}

Widget _showBadgeWidget(context) {
  return FutureBuilder(
    future: Getters.getBadgesDB(context),
    builder: (BuildContext context, AsyncSnapshot<List<MyBadge?>> snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasData && snapshot.data != null) {
          List<MyBadge> badges = snapshot.data!
              .where((element) => element != null)
              .map((e) => e!)
              .toList();
          if (badges.isNotEmpty) {
            return ListView.builder(
              itemCount: badges.length,
              itemBuilder: (context, index) {
                return defaultInputDecorator(
                  badges[index].getBadge().badgeName,
                  badges[index].date,
                  Icons.star,
                );
              },
            );
          } else {
            return Center(
              child: defaultText('No badge found'),
            );
          }
        } else {
          return Center(
            child: defaultText('No badge found'),
          );
        }
      } else {
        return defaultLoadingScreen();
      }
    },
  );
}

/// APPBAR - DO NOT TOUCH
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
