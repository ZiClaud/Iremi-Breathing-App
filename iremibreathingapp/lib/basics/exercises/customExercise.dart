import 'package:iremibreathingapp/basics/exercises/exercise.dart';

class CustomExercise extends Exercise {
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

  CustomExercise(this.name, this.description, this.notes, this.steps,
      this.times, inhaleTime, holdMiddleTime, exhaleTime, holdEndTime,
      {inhaleTimeMs = 0,
      holdMiddleTimeMs = 0,
      exhaleTimeMs = 0,
      holdEndTimeMs = 0}) {
    this.inhaleDuration =
        Duration(seconds: inhaleTime, milliseconds: inhaleTimeMs);
    this.holdMiddleDuration =
        Duration(seconds: holdMiddleTime, milliseconds: holdMiddleTimeMs);
    this.exhaleDuration =
        Duration(seconds: exhaleTime, milliseconds: exhaleTimeMs);
    this.holdEndDuration =
        Duration(seconds: holdEndTime, milliseconds: holdEndTimeMs);
  }
}
