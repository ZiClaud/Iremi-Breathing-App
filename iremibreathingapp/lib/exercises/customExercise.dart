import 'package:iremibreathingapp/exercises/exercise.dart';

class CustomExercise extends Exercise {
  @override
  List<String> steps;

  @override
  double inhaleTime;

  @override
  double holdMiddleTime;

  @override
  double exhaleTime;

  @override
  double holdEndTime;

  CustomExercise(this.steps, this.inhaleTime, this.holdMiddleTime,
      this.exhaleTime, this.holdEndTime);
}
