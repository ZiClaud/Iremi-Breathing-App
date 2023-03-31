import 'package:iremibreathingapp/basics/exercises/deepBreathingExercise.dart';

class DeepBreathingExerciseAvanced extends DeepBreathingExercise {
  @override
  String name = "Deep Breathing Avanced";

  @override
  int inhaleTimeMs = 4 * 1000;

  @override
  int holdMiddleTimeMs = 4 * 1000;

  @override
  int exhaleTimeMs = 4 * 1000;

  @override
  int holdEndTimeMs = 4 * 1000;

  @override
  int times = 30;
}
