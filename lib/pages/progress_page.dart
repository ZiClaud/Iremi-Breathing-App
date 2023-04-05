import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/badge.dart';
import 'package:iremibreathingapp/basics/exercise_history.dart';

import '../database/getters.dart';
import '../utils/default_widgets.dart';

class ProgressPage extends StatefulWidget {
  ProgressPage({Key? key}) : super(key: key);

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
            child: defaultExerciseHistoryWidget(_exerciseHistory),
          ),
          Expanded(
            flex: 1,
            child: _showBadgeWidget(_badges),
          ),
        ],
      ),
//      bottomNavigationBar: getBottomNavigationBar(context, 0),
    );
  }
}

Widget _showBadgeWidget(List<MyBadge?> badges) {
  List<MyBadge> allBadges = _getAllBadges(badges);

  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: allBadges.length,
    itemBuilder: (context, index) {
      return defaultBadgeView(context, allBadges, index);
    },
  );
}

List<MyBadge> _getAllBadges(List<MyBadge?> badges) {
  List<MyBadge> allBadges = [];

  for (PossibleBadges possibleBadges in PossibleBadges.values) {
    allBadges.add(MyBadge(id: possibleBadges.id, date: ""));
  }

  for (int i = 0; i < badges.length; i++) {
    for (MyBadge allBadge in allBadges) {
      for (MyBadge? badge in badges) {
        if (badge!.id == allBadge.id) {
          allBadges.remove(allBadge);
        }
      }
    }
  }

  return allBadges;
}
