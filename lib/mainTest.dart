import 'package:iremibreathingapp/basics/exercises/customExercise.dart';
import 'package:iremibreathingapp/basics/exercises/deepBreathingExerciseBeginner.dart';
import 'package:iremibreathingapp/basics/exercises/exercise.dart';

void main() {
  MyExercise deepBreathing = DeepBreathingExerciseBeginner();
  MyExercise customBreathing =
      CustomExercise("Custom", "", "", ["s1", "s2"], 1, 1, 1, 1, 3);

  deepBreathing.tellSteps();
  customBreathing.tellSteps();

  print("deepBeginner");
//  deepBreathing.start();

  print("custom");
  customBreathing.start();
}
