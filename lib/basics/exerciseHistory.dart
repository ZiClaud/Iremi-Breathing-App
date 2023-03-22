import 'package:iremibreathingapp/basics/exercise.dart';

class ExerciseHistory {
  final int? id;
  Map<DateTime, MyExercise> exercises;

  ExerciseHistory({this.id, required this.exercises});
}
