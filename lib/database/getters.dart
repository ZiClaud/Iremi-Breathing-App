import 'package:iremibreathingapp/basics/exercises/b478Exercise.dart';
import 'package:iremibreathingapp/basics/exercises/boxBreathingExercise.dart';
import 'package:iremibreathingapp/basics/exercises/customExercise.dart';
import 'package:iremibreathingapp/basics/exercises/deepBreathingExerciseBeginner.dart';
import 'package:iremibreathingapp/basics/exercises/exercise.dart';
import 'package:iremibreathingapp/basics/settings.dart';
import 'package:iremibreathingapp/basics/user.dart';

import '../basics/exercises/deepBreathingExerciseAvanced.dart';
import '../basics/exercises/deepBreathingExerciseIntermediate.dart';

class Getters {
  static List<MyExercise> getExercises() {
    List<MyExercise> ex = [
      DeepBreathingExerciseBeginner(),
      DeepBreathingExerciseIntermediate(),
      DeepBreathingExerciseAvanced(),
      B478Exercise(),
      BoxBreathingExercise(),
      CustomExercise("DEV: Fast", "Used by developer", "N/A", ["N/A"], 1, 1, 1, 1, 1),
      CustomExercise("DEV: Faster", "Used by developer", "N/A", ["N/A"], 1, 0, 0, 0, 0,
          inhaleTimeMs: 1,
          holdMiddleTimeMs: 1,
          exhaleTimeMs: 1,
          holdEndTimeMs: 1),
      /*
      CustomExercise("1234", "", "", ["s1", "s2"], 1, 2, 3, 4, 5),
      CustomExercise("Milliseconds", "", "", ["s1", "s2"], 10, 1, 1, 1, 1,
          inhaleTimeMs: 500),
      CustomExercise("Milliseconds 2", "", "", ["s1", "s2"], 5, 1, 1, 1, 1,
          inhaleTimeMs: 500,
          holdMiddleTimeMs: 500,
          exhaleTimeMs: 500,
          holdEndTimeMs: 500),
      */
    ];

    return ex;
  }

  static MyUser getUser() {
    return MyUser(
        username: "ZiCli",
        name: "Claudio",
        surname: "Di Maio",
        sex: "M",
        goal: "5 min - day",
        badges: "Badges");
  }

  static MySettings getSettings() {
    return MySettings("Italian", false, false, true, "Male");
  }
}
