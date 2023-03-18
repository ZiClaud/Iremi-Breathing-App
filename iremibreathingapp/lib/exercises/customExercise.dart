import 'package:iremibreathingapp/exercises/exercise.dart';

class CustomExercise extends Exercise {
  @override
  List<String> steps;

  @override
  late Duration inhaleTime;

  @override
  late Duration holdMiddleTime;

  @override
  late Duration exhaleTime;

  @override
  late Duration holdEndTime;

  @override
  int times;

  CustomExercise(
      this.steps, inhaleTime, holdMiddleTime, exhaleTime, holdEndTime, this.times) {
    this.inhaleTime = Duration(seconds: inhaleTime);
    this.holdMiddleTime = Duration(seconds: holdMiddleTime);
    this.exhaleTime = Duration(seconds: exhaleTime);
    this.holdEndTime = Duration(seconds: holdEndTime);
  }
}
