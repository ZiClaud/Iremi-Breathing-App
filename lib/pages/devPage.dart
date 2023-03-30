import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iremibreathingapp/utils/defaultWidget.dart';

import '../basics/badge.dart';

class DevPage extends StatefulWidget {
  DevPage({Key? key}) : super(key: key);

  @override
  State<DevPage> createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {
  void _doDevStuff(BuildContext context) {
    // TODO: Do dev stuff
  }

  Future<void> _addRandomAchievement(context) async {
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
              _doDevStuff(context);
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
            flex: 1,
            child: _getAchievementListView(context),
          ),
        ],
      ),
    );
  }

  Widget _getAchievementListView(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        defaultBadgeView(
          PossibleBadges.breathingExplorer.badgeName,
          "02/12/2022",
          PossibleBadges.breathingExplorer.icon,
        ),
        defaultBadgeView(
          PossibleBadges.beginner.badgeName,
          "12/12/2022",
          PossibleBadges.beginner.icon,
        ),
        defaultBadgeView(
          PossibleBadges.rater.badgeName,
          "12/12/2022",
          PossibleBadges.rater.icon,
        ),
        defaultBadgeView(
          PossibleBadges.richBoi.badgeName,
          "12/12/2022",
          PossibleBadges.richBoi.icon,
        ),
        defaultBadgeView(
          PossibleBadges.calmAndCollected.badgeName,
          "12/12/2022",
          PossibleBadges.calmAndCollected.icon,
        ),
      ],
    );
  }

  Widget _getUserListView(BuildContext context) {
    return ListView(
      children: [
        defaultInputDecorator("Username", "user.username", Icons.person),
        defaultInputDecorator("Name", "user.name", Icons.badge_outlined),
        defaultInputDecorator("Sex", "user.sex", Icons.search),
        defaultInputDecorator("Goal", "user.goal", Icons.ads_click),
      ],
    );
  }
}
