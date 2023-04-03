import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/exercise_custom.dart';
import 'package:iremibreathingapp/utils/default_widgets.dart';
import 'package:iremibreathingapp/utils/my_utils.dart';

import '../basics/badge.dart';
import '../database/database.dart';

class DevPage extends StatefulWidget {
  DevPage({Key? key}) : super(key: key);

  @override
  State<DevPage> createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {
  Future<void> _doDevStuff1(BuildContext context) async {
    try {
      await DBCustomExercise().createExercise(CustomExercise(
        name: "Fast",
        description: "test",
        notes: 'note',
        steps: [],
        times: 1,
        inhaleTimeMs: 1000,
        holdMiddleTimeMs: 1000,
        exhaleTimeMs: 1000,
        holdEndTimeMs: 1000,
      ));
    } catch (e) {
      defaultDatabaseErrorDialog(context, e.toString());
      print(e);
    }

    defaultDialog(context, "Success", "Saved exercise to database");
    try {
      DBCustomExercise().readAllExercises().then((value) =>
          defaultDialog(context, "N. of exercises:", value.length.toString()));
    } catch (e) {
      defaultDatabaseErrorDialog(context, e.toString());
    }
  }

  Future<void> _doDevStuff2(BuildContext context) async {
    try {
      await DBCustomExercise().createExercise(CustomExercise(
        name: "Faster",
        description: "This is a test exercise",
        notes: 'This is a test note',
        steps: ['Inhale', 'Exhale', 'Hold'],
        times: 2,
        inhaleTimeMs: 1,
        holdMiddleTimeMs: 1,
        exhaleTimeMs: 1,
        holdEndTimeMs: 1,
      ));
      defaultDialog(context, "Success", "Saved exercise to database");
      try {
        DBCustomExercise().readAllExercises().then((value) => defaultDialog(
            context, "N. of exercises:", value.length.toString()));
      } catch (e) {
        defaultDatabaseErrorDialog(context, e.toString());
      }
    } catch (e) {
      defaultDatabaseErrorDialog(context, e.toString());
      print(e);
    }
  }

  Future<void> _doDevStuff3(BuildContext context) async {
    try {
      await DBCustomExercise().createExercise(CustomExercise(
        name: "Test Exercise 2",
        description: "This is a test exercise",
        notes: 'This is a test note',
        steps: ['Inhale'],
        times: 2,
        inhaleTimeMs: 1000,
        holdMiddleTimeMs: 1000,
        exhaleTimeMs: 1000,
        holdEndTimeMs: 1000,
      ));
      defaultDialog(context, "Success", "Saved exercise to database");
      try {
        DBCustomExercise().readAllExercises().then((value) => defaultDialog(
            context, "N. of exercises:", value.length.toString()));
      } catch (e) {
        defaultDatabaseErrorDialog(context, e.toString());
      }
    } catch (e) {
      defaultDatabaseErrorDialog(context, e.toString());
      print(e);
    }
  }

  Future<void> _addRandomAchievement(context) async {
    // TODO: Remove
    Random random = Random();
    int id = random.nextInt(Achievement.getMaxID());

    Achievement.addAchievement(Achievement.getBadgeByID(id), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DEV Page"),
        actions: [
          if (isDev)
            IconButton(
              icon: const Icon(Icons.code),
              onPressed: () {
                _doDevStuff1(context);
              },
            ),
          if (isDev)
            IconButton(
              icon: const Icon(Icons.cloud),
              onPressed: () {
                _doDevStuff2(context);
              },
            ),
          if (isDev)
            IconButton(
              icon: const Icon(Icons.code_off),
              onPressed: () {
                _doDevStuff3(context);
              },
            ),
          if (isDev)
            IconButton(
              icon: const Icon(Icons.star),
              onPressed: () {
                _addRandomAchievement(context);
              },
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: _getUserListView(context),
          ),
          Expanded(
            flex: 1,
            child: _getAchievementListView(context),
          ),
        ],
      ),
    );
  }

  Widget _getAchievementListView(BuildContext context) {
    return ListView.builder(
      itemCount: PossibleBadges.values.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return defaultBadgeView(
          PossibleBadges.values[index].badgeName,
          "30/03/2023",
          PossibleBadges.values[index].icon,
        );
      },
    );
  }

  Widget _getUserListView(BuildContext context) {
    return ListView(
      children: [
        defaultInputDecorator("Username", "DEV", Icons.person),
        defaultInputDecorator("Name", "Developer", Icons.badge_outlined),
        defaultInputDecorator("Sex", "No", Icons.search),
        defaultInputDecorator("Goal", "24h/day", Icons.ads_click),
      ],
    );
  }
}
