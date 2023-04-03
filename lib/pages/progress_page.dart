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
            flex: 2, // TODO: Check it it works well on different devices
            child: _showExerciseHistoryWidget(_exerciseHistory),
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
