import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/exercise.dart';
import 'package:iremibreathingapp/basics/exercises/b478Exercise.dart';
import 'package:iremibreathingapp/basics/exercises/boxBreathingExercise.dart';
import 'package:iremibreathingapp/basics/exercises/customExercise.dart';
import 'package:iremibreathingapp/basics/exercises/deepBreathingExerciseBeginner.dart';
import 'package:iremibreathingapp/basics/settings.dart';
import 'package:iremibreathingapp/basics/user.dart';
import 'package:iremibreathingapp/utils/myUtils.dart';

import '../basics/exercises/deepBreathingExerciseAvanced.dart';
import '../basics/exercises/deepBreathingExerciseIntermediate.dart';
import 'database.dart';

class Getters {
  static List<MyExercise> getExercises() {
    List<MyExercise> ex = [
      DeepBreathingExerciseBeginner(),
      DeepBreathingExerciseIntermediate(),
      DeepBreathingExerciseAvanced(),
      B478Exercise(),
      BoxBreathingExercise(),
      CustomExercise(
          name: "DEV: Fast",
          description: "Used by developer",
          notes: "N/A",
          steps: ["N/A"],
          times: 1,
          inhaleTime: 1,
          holdMiddleTime: 1,
          exhaleTime: 1,
          holdEndTime: 1),
      CustomExercise(
          name: "DEV: Faster",
          description: "Used by developer",
          notes: "N/A",
          steps: ["N/A"],
          times: 1,
          inhaleTime: 0,
          holdMiddleTime: 0,
          exhaleTime: 0,
          holdEndTime: 0,
          inhaleTimeMs: 1,
          holdMiddleTimeMs: 1,
          exhaleTimeMs: 1,
          holdEndTimeMs: 1),
    ];

    return ex;
  }

  static CustomExercise getCustomExercise() {
    // TODO: REMOVE - Now it's replacing DB stuff
    return CustomExercise(
        name: "DEV: Fast",
        description: "Used by developer",
        notes: "N/A",
        steps: ["N/A"],
        times: 1,
        inhaleTime: 1,
        holdMiddleTime: 1,
        exhaleTime: 1,
        holdEndTime: 1);
  }

  static Future<List<CustomExercise?>> getCustomExercises() async {
    // TODO: Replace with DB stuff
    return await [getCustomExercise()];
  }

  static Future<MyUser?> getUser() {
    return MyUser(
      username: "ZiCli",
      name: "Claudio",
      surname: "Di Maio",
      sex: "M",
      goal: "5 min - day",
    ) as Future<MyUser>;
  }

  static Future<MyUser?> getUserDB(context) async {
    try {
      return await MyDatabase.instance.getFirstUser();
    } catch (e) {
      defaultDatabaseErrorDialog(context, e);
    }
  }

  static MySettings getDefaultSettings() {
    return MySettings(
        language: getDefaultLanguage(),
        darkmode: getDefaultTheme() == ThemeMode.dark ? true : false,
        music: true,
        voice: true,
        voiceType: "Male");
  }

  static Future<MySettings?> getSettingsDB(context) async {
    try {
      // TODO: CHANGE
      return await MySettings(
          language: getDefaultLanguage(),
          darkmode: getDefaultTheme() == ThemeMode.dark ? true : false,
          music: false,
          voice: true,
          voiceType: "Male");
    } catch (e) {
      defaultDatabaseErrorDialog(context, e);
      return getDefaultSettings();
    }
  }
}
