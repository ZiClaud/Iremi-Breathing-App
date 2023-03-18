import 'package:iremibreathingapp/exercises/customExercise.dart';
import 'package:iremibreathingapp/exercises/deepBreathingExerciseBeginner.dart';
import 'package:iremibreathingapp/exercises/exercise.dart';

void main() {
  Exercise deepBreathing = DeepBreathingExerciseBeginner();
  Exercise customBreathing = CustomExercise(["steps", "steps"], 0, 0, 0, 0);

  deepBreathing.tellSteps();
  customBreathing.tellSteps();
}