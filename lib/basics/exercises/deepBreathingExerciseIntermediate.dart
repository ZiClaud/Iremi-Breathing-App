import 'package:iremibreathingapp/basics/exercises/deepBreathingExercise.dart';

class DeepBreathingExerciseIntermediate extends DeepBreathingExercise {
  @override
  String name = "Deep Breathing Intermediate";

  @override
  int inhaleTimeMs = 4 * 1000;

  @override
  int holdMiddleTimeMs = 4 * 1000;

  @override
  int exhaleTimeMs = 4 * 1000;

  @override
  int holdEndTimeMs = 4 * 1000;

  @override
  int times = 10;
}
