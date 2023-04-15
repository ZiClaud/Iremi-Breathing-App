import 'package:iremibreathingapp/basics/exercises/exercise_deep_breathing.dart';

class DeepBreathingExerciseIntermediate extends DeepBreathingExercise {
  @override
  String name() {
    return "Deep Breathing Intermediate";
  }

  @override
  int inhaleTimeMs() {
    return 4 * 1000;
  }

  @override
  int holdMiddleTimeMs() {
    return 4 * 1000;
  }

  @override
  int exhaleTimeMs() {
    return 4 * 1000;
  }

  @override
  int holdEndTimeMs() {
    return 4 * 1000;
  }

  @override
  int times() {
    return 10;
  }
}
