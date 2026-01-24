import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../basics/exercise_history.dart';
import '../utils/theme.dart';

/// CHART
class DefaultExerciseHistoryWidget extends StatelessWidget {
  final List<ExerciseHistory> exerciseHistory;

  const DefaultExerciseHistoryWidget(
      {super.key, required this.exerciseHistory});

  @override
  Widget build(BuildContext context) {
    _filterExerciseHistory(exerciseHistory);
    return SfCartesianChart(
      series: <CartesianSeries>[
        ColumnSeries<ExerciseHistory, DateTime>(
          dataSource: exerciseHistory,
          xValueMapper: (e, _) =>
              DateTime(e.dateTime.year, e.dateTime.month, e.dateTime.day),
          yValueMapper: (ExerciseHistory sales, _) =>
              sales.exerciseDurationSeconds,
          name: 'Exercise History',
          color: myBluLightDark(),
          dataLabelSettings: const DataLabelSettings(isVisible: false),
        )
      ],
      primaryXAxis: DateTimeAxis(
          intervalType: DateTimeIntervalType.days,
          dateFormat: DateFormat.E(),
          majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          name: "Seconds",
          isVisible: true,
          majorGridLines: const MajorGridLines(width: 0)),
    );
  }
}

List<ExerciseHistory> _filterExerciseHistory(
    List<ExerciseHistory> exerciseHistory) {
  List<DateTime> dateTimes = []; // List of the dateTimes

  // Add the past 6 days + today
  for (int i = 0; i < 7; i++) {
    dateTimes.add(DateTime.now().subtract(Duration(days: i)));
  }

  List<ExerciseHistory> exerciseHistoryFiltered = [];

  for (DateTime dateTime in dateTimes) {
    exerciseHistoryFiltered
        .add(_sumDurationExerciseHistoryThisDay(exerciseHistory, dateTime));
  }

  exerciseHistoryFiltered.sort((a, b) => a.dateTime.compareTo(b.dateTime));

  return exerciseHistoryFiltered;
}

ExerciseHistory _sumDurationExerciseHistoryThisDay(
    List<ExerciseHistory> exerciseHistory, DateTime dateTime) {
  int sumDuration = 0;
  for (ExerciseHistory eh in exerciseHistory) {
    if (eh.dateTime.day == dateTime.day &&
        eh.dateTime.month == dateTime.month &&
        eh.dateTime.year == dateTime.year) {
      sumDuration += eh.exerciseDurationSeconds;
    }
  }
  return ExerciseHistory(
      exerciseDurationSeconds: sumDuration, dateTime: dateTime);
}
