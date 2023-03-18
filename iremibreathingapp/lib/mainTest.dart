import 'package:iremibreathingapp/exercises/customExercise.dart';
import 'package:iremibreathingapp/exercises/deepBreathingExerciseBeginner.dart';
import 'package:iremibreathingapp/exercises/exercise.dart';

void main() {
  Exercise deepBreathing = DeepBreathingExerciseBeginner();
  Exercise customBreathing =
      CustomExercise("Custom", "", "", ["s1", "s2"], 1, 1, 1, 1, 3);

  deepBreathing.tellSteps();
  customBreathing.tellSteps();

  print("deepBeginner");
//  deepBreathing.start();

  print("custom");
  customBreathing.start();
}
