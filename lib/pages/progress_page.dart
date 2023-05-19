import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/badge.dart';
import 'package:iremibreathingapp/basics/exercise_history.dart';

import '../database/getters.dart';
import '../utils/default_widgets.dart';
import '../utils/my_utils.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  List<MyBadge> _badges = [];
  List<ExerciseHistory> _exerciseHistory = [];

  @override
  void initState() {
    super.initState();
    _getBadges();
    _getExerciseHistory();
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
    List<ExerciseHistory> exerciseHistory =
        await Getters.getExerciseHistoryDB(context);
    if (exerciseHistory.isNotEmpty) {
      setState(() {
        _exerciseHistory = exerciseHistory;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Text("Streak: ${getExHistoryStreak(_exerciseHistory)}"),
                  if (isDev)
                    Text(
                        "Morning: ${getExHistoryMorningTimes(_exerciseHistory)}"),
                  if (isDev)
                    Text(
                        "Evening: ${getExHistoryNightTimes(_exerciseHistory)}"),
                  DefaultExerciseHistoryWidget(exerciseHistory: _exerciseHistory),
                ],
              ),
            ),
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

Widget _showBadgeWidget(List<MyBadge> badges) {
  List<PossibleBadges> allPossibleBadges = [];
  allPossibleBadges.addAll(PossibleBadges.values);

  for (int i = 0; i < badges.length; i++) {
    allPossibleBadges.remove(badges[i].getBadge());
  }

  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: allPossibleBadges.length + badges.length,
    itemBuilder: (context, index) {
      if (index < badges.length) {
        return defaultBadgeView(
          context,
          badges[index],
        );
      } else {
        return defaultLockedBadgeView(
          context,
          allPossibleBadges[index - badges.length],
        );
      }
    },
  );
}
