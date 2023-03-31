import 'package:iremibreathingapp/basics/exercises/deepBreathingExercise.dart';

class DeepBreathingExerciseBeginner extends DeepBreathingExercise {
  @override
  String name = "Deep Breathing Beginner";

  @override
  int inhaleTimeMs = 2 * 1000;

  @override
  int holdMiddleTimeMs = 2 * 1000;

  @override
  int exhaleTimeMs = 2 * 1000;

  @override
  int holdEndTimeMs = 2 * 1000;

  @override
  int times = 5;
}
