import 'package:iremibreathingapp/basics/exercise.dart';
import 'package:iremibreathingapp/basics/exercises/b478Exercise.dart';
import 'package:iremibreathingapp/basics/exercises/boxBreathingExercise.dart';
import 'package:iremibreathingapp/basics/exercises/customExercise.dart';
import 'package:iremibreathingapp/basics/exercises/deepBreathingExerciseBeginner.dart';
import 'package:iremibreathingapp/basics/user.dart';
import 'package:iremibreathingapp/utils/myUtils.dart';

import '../basics/exercises/deepBreathingExerciseAvanced.dart';
import '../basics/exercises/deepBreathingExerciseIntermediate.dart';
import 'database.dart';

class Getters {
  static List<MyExercise> getDefaultExercises() {
    List<MyExercise> ex = [
      DeepBreathingExerciseBeginner(),
      DeepBreathingExerciseIntermediate(),
      DeepBreathingExerciseAvanced(),
      B478Exercise(),
      BoxBreathingExercise(),
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
    return await [
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
          steps: [],
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
  }

  static Future<MyUser?> getUser() {
    return MyUser(
      username: "ZiCli",
      name: "Claudio",
      sex: "M",
      goal: "5 min - day",
    ) as Future<MyUser>;
  }

  static Future<MyUser?> getUserDB(context) async {
    try {
      return await MyDatabase.instance.getFirstUser();
    } catch (e) {
      defaultDatabaseErrorDialog(context, e);
      rethrow;
    }
  }

  static List<String> getAvailableLanguages() {
    return ['English', 'Italian', 'Spanish', 'Chinese (Simplified)', 'Greek'];
  }

  static String getFirstLanguage(){
    return getAvailableLanguages().first;
  }

  static List<String> getAvailableVoiceTypes() {
    return ['Male', 'Female', 'Neutral'];
  }

  static String getFirstVoiceType(){
    return getAvailableVoiceTypes().first;
  }
/*
  static MySettings getDefaultSettings() {
    return MySettings(
        language: getDefaultLanguage(),
        darkmode: getDefaultTheme2(),
        music: true,
        voice: true,
        voiceType: "Male");
  }

  static Future<MySettings> getSettingsDB(context) async {
    try {
      return await MyDatabase.instance.getFirstSettings() ?? getDefaultSettings();
    } catch (e) {
      defaultDatabaseErrorDialog(context, e);
      return getDefaultSettings();
    }
  }
  */
}
