import 'package:iremibreathingapp/basics/exercises/exercise_deep_breathing.dart';

class DeepBreathingExerciseBeginner extends DeepBreathingExercise {
  @override
  String name() {
    return "Deep Breathing Beginner";
  }

  @override
  int inhaleTimeMs() {
    return 2 * 1000;
  }

  @override
  int holdMiddleTimeMs() {
    return 2 * 1000;
  }

  @override
  int exhaleTimeMs() {
    return 2 * 1000;
  }

  @override
  int holdEndTimeMs() {
    return 2 * 1000;
  }

  @override
  int times() {
    return 5;
  }
}
