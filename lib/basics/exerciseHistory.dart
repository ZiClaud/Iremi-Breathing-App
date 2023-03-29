import 'package:iremibreathingapp/basics/exercise.dart';

class ExerciseHistory {
  final int? id;
  MyExercise exercise;
  DateTime dateTime;

  ExerciseHistory({this.id, required this.exercise, required this.dateTime});
}
