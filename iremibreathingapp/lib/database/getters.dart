import 'package:iremibreathingapp/basics/exercises/customExercise.dart';
import 'package:iremibreathingapp/basics/exercises/deepBreathingExerciseBeginner.dart';
import 'package:iremibreathingapp/basics/exercises/exercise.dart';
import 'package:iremibreathingapp/basics/user.dart';

import '../basics/exercises/deepBreathingExerciseIntermediate.dart';

class Getters {
  static List<Exercise> getExercises() {
    List<Exercise> ex = [
      DeepBreathingExerciseBeginner(),
      DeepBreathingExerciseIntermediate(),
      /*
      CustomExercise("0001", "", "", [""], 0, 0, 0, 1, 1),
      CustomExercise("0010", "", "", [""], 0, 0, 1, 0, 1),
      CustomExercise("0100", "", "", [""], 0, 1, 0, 0, 1),
      CustomExercise("1000", "", "", [""], 1, 0, 0, 0, 1),
      CustomExercise("1010", "", "", [""], 1, 0, 1, 0, 1),
      CustomExercise("0101", "", "", [""], 0, 1, 0, 1, 1),
      */
      CustomExercise("1111", "", "", [""], 1, 1, 1, 1, 1),
      CustomExercise("1234", "", "", ["s1", "s2"], 1, 2, 3, 4, 5),
    ];

    return ex;
  }
  
  static MyUser getUser(){
    return MyUser("ZiCli", "Claudio", "Di Maio", "M",
        "5 min - day", "Badges", "Italian", "Exercise History", "Settings");
  }
}
