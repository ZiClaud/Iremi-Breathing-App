import 'package:iremibreathingapp/exercises/customExercise.dart';
import 'package:iremibreathingapp/exercises/deepBreathingExerciseBeginner.dart';
import 'package:iremibreathingapp/exercises/exercise.dart';

import '../exercises/deepBreathingExerciseIntermediate.dart';

class Getters {
  static List<Exercise> getExercises() {
    List<Exercise> ex = [
      DeepBreathingExerciseBeginner(),
      DeepBreathingExerciseIntermediate(),
      CustomExercise("0000", "", "", [""], 0, 0, 0, 0, 1),
      CustomExercise("1010", "", "", [""], 1, 0, 1, 0, 1),
      CustomExercise("0101", "", "", [""], 0, 1, 0, 1, 1),
      CustomExercise("1111", "", "", [""], 1, 1, 1, 1, 1),
      CustomExercise("Custom", "", "", ["s1", "s2"], 1, 1, 1, 1, 3),
    ];

    return ex;
  }
}
