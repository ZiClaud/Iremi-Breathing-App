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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("DEV Page"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: OutlinedButton(
                  child: const Icon(Icons.code),
                  onPressed: () {
                    _doDevStuff(context);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: OutlinedButton(
                  child: const Icon(Icons.badge),
                  onPressed: () {
                    _addRandomAchievement(context);
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView(
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
              ),
            ),
          ],
        ));
  }
}

void _doDevStuff(BuildContext context) {}

Future<void> _addRandomAchievement(context) async {
  Random random = Random();
  int id = random.nextInt(PossibleBadges.getMaxID());

  Achievement.addAchievement(PossibleBadges.getBadgeByID(id), context);
}
