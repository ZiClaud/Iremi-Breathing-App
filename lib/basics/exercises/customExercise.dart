import 'package:iremibreathingapp/basics/exercise.dart';

class CustomExercise extends MyExercise {
  late final int? id; // TODO: stuff
  @override
  String name;

  @override
  String description;

  @override
  String notes;

  @override
  List<String> steps;

  @override
  late Duration inhaleDuration;

  @override
  late Duration holdMiddleDuration;

  @override
  late Duration exhaleDuration;

  @override
  late Duration holdEndDuration;

  @override
  int times;

  CustomExercise(
      {this.id,
      required this.name,
      required this.description,
      required this.notes,
      required this.steps,
      required this.times,
      required inhaleTime,
      required holdMiddleTime,
      required exhaleTime,
      required holdEndTime,
      inhaleTimeMs = 0,
      holdMiddleTimeMs = 0,
      exhaleTimeMs = 0,
      holdEndTimeMs = 0}) {
    inhaleDuration =
        Duration(seconds: inhaleTime, milliseconds: inhaleTimeMs);
    holdMiddleDuration =
        Duration(seconds: holdMiddleTime, milliseconds: holdMiddleTimeMs);
    exhaleDuration =
        Duration(seconds: exhaleTime, milliseconds: exhaleTimeMs);
    holdEndDuration =
        Duration(seconds: holdEndTime, milliseconds: holdEndTimeMs);
  }
}
