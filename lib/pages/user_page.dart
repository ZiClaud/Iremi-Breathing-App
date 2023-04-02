import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/badge.dart';
import 'package:iremibreathingapp/basics/exercise_history.dart';
import 'package:iremibreathingapp/pages/register_page.dart';
import 'package:iremibreathingapp/pages/settings_page.dart';

import '../basics/user.dart';
import '../database/getters.dart';
import '../utils/default_widgets.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  MyUser? _user;
  List<MyBadge> _badges = [];
  List<ExerciseHistory> _exerciseHistory = [];

  @override
  void initState() {
    super.initState();
    _getUser();
    _getBadges();
    _getExerciseHistory();
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

  Future<void> _getExerciseHistory() async {
    List<ExerciseHistory> exerciseHistory = await Getters.getExerciseHistoryDB(context);
    if (exerciseHistory.isNotEmpty) {
      setState(() {
        _exerciseHistory = exerciseHistory;
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
            flex: 2, // TODO: Check it it works well on different devices
            child: _showExerciseHistoryWidget(_exerciseHistory),
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
          child: defaultText('No badge found'), // 'No badge found'
        );
}

Widget _showExerciseHistoryWidget(List<ExerciseHistory> exerciseHistory) {
  return (exerciseHistory.isNotEmpty)
      ? defaultExerciseHistoryWidget(exerciseHistory)
      : Center(
    child: defaultText('No exercise history found'),
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
