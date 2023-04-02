import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/customExercise.dart';
import 'package:iremibreathingapp/basics/exerciseHistory.dart';
import 'package:iremibreathingapp/utils/defaultWidget.dart';
import 'package:iremibreathingapp/utils/myUtils.dart';

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
        name: "Test",
        description: "test",
        notes: 'note',
        steps: [],
        times: 2,
        inhaleTimeMs: 1000,
        holdMiddleTimeMs: 1000,
        exhaleTimeMs: 1000,
        holdEndTimeMs: 1000,
      ));
    } catch (e) {
      defaultDatabaseErrorDialog(context, e.toString());
      print(e);
    }

    /*
      await DBCustomExercise().createExercise(CustomExercise(
        name: "Test Exercise",
        description: "This is a test exercise",
        notes: 'This is a test note',
        steps: ['Inhale'],
        times: 2,
        inhaleTimeMs: 1000,
        holdMiddleTimeMs: 1000,
        exhaleTimeMs: 1000,
        holdEndTimeMs: 1000,
      ));
      */

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
        name: "Test Exercise",
        description: "This is a test exercise",
        notes: 'This is a test note',
        steps: ['Inhale', 'Exhale', 'Hold'],
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
          IconButton(
            icon: const Icon(Icons.code),
            onPressed: () {
              _doDevStuff1(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.cloud),
            onPressed: () {
              _doDevStuff2(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.code_off),
            onPressed: () {
              _doDevStuff3(context);
            },
          ),
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
            flex: 3, // TODO: Check it it works well on different devices
            child: _getUserListView(context),
          ),
          Expanded(
            flex: 1, // TODO: Check it it works well on different devices
            child: _showExerciseHistoryWidget(context),
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

  Widget _showExerciseHistoryWidget(BuildContext context) {
    List<ExerciseHistory> exerciseHistory = [
      ExerciseHistory(exerciseDurationSeconds: 200, dateTime: DateTime.now()),
      ExerciseHistory(exerciseDurationSeconds: 500, dateTime: DateTime.now()),
    ];
    return (exerciseHistory.isNotEmpty)
        ? ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: exerciseHistory.length,
            itemBuilder: (context, index) {
              return defaultBadgeView(
                exerciseHistory[index]!.exerciseDurationSeconds.toString(),
                exerciseHistory[index]!.dateTime.toString(),
                Icons.history,
              );
            },
          )
        : Center(
            child: defaultText('No exercise history found'),
          );
  }
}
