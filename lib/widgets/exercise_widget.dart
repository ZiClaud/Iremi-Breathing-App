import 'package:flutter/material.dart';
import 'package:iremibreathingapp/widgets/text_field_widget.dart';

import '../basics/exercise.dart';
import '../utils/my_utils.dart';
import '../utils/theme.dart';

Widget showExerciseModel(MyExercise exercise) {
  return Card(
    elevation: 2.0,
    shape: defaultRoundedRectangleBorder(),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name(),
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    Icon(Icons.timer_outlined, size: 16.0, color: myWhiteBlack()),
                    // TODO: Fix the color, of the icon it doesn't update on dark mode change
                    const SizedBox(width: 4.0),
                    Text(
                      getTimeString(exercise),
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

TabBar defaultExerciseTopBar(TabController controller) {
  return TabBar(
    controller: controller,
    tabs: const [
      Tab(text: 'Details'),
      Tab(text: 'Steps'),
    ],
    indicatorColor: myBluNeutral(),
  );
}
