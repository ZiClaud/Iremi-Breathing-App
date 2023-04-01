import 'package:iremibreathingapp/basics/exercise.dart';
import 'package:iremibreathingapp/basics/exerciseHistory.dart';
import 'package:iremibreathingapp/basics/exercises/b478Exercise.dart';
import 'package:iremibreathingapp/basics/exercises/boxBreathingExercise.dart';
import 'package:iremibreathingapp/basics/customExercise.dart';
import 'package:iremibreathingapp/basics/exercises/deepBreathingExerciseBeginner.dart';
import 'package:iremibreathingapp/basics/user.dart';
import 'package:iremibreathingapp/utils/myUtils.dart';

import '../basics/badge.dart';
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

  static List<String> getAvailableLanguages() {
    return ['English', 'Italian', 'Spanish', 'Chinese (Simplified)', 'Greek'];
  }

  static String getFirstLanguage() {
    // TODO: Replace with something that gets the default language
    return getAvailableLanguages().first;
  }

  static List<String> getAvailableVoiceTypes() {
    return ['Male', 'Female', 'Neutral'];
  }

  static String getFirstVoiceType() {
    return getAvailableVoiceTypes().first;
  }

  static Future<MyUser?> getUserDB(context) async {
    try {
      return await DBMyUser().getFirstUser();
    } catch (e) {
      defaultDatabaseErrorDialog(context, e.toString());
      rethrow;
    }
  }

  static Future<List<MyBadge>> getBadgesDB(context) async {
    try {
      List<MyBadge?> val = await DBMyBadge().readAllBadges();
      List<MyBadge> ris = [];

      for (MyBadge? badge in val) {
        if (badge != null) {
          ris.add(badge);
        }
      }

      return ris;
    } catch (e) {
      defaultDatabaseErrorDialog(context, e.toString());
      rethrow;
    }
  }

  static Future<List<CustomExercise>> getCustomExercisesDB(context) async {
    try {
      List<CustomExercise?> val = await DBCustomExercise().readAllExercises();
      List<CustomExercise> ris = [];

      for (CustomExercise? customExercise in val) {
        if (customExercise != null) {
          ris.add(customExercise);
        }
      }

      return ris;
    } catch (e) {
      defaultDatabaseErrorDialog(context, e.toString());
      rethrow;
    }
  }

  static Future<List<ExerciseHistory>> getExerciseHistoryDB(context) async {
    try {
      List<ExerciseHistory?> val = await DBExerciseHistory().readAllExerciseHistory();
      List<ExerciseHistory> ris = [];

      for (ExerciseHistory? exerciseHistory in val) {
        if (exerciseHistory != null) {
          ris.add(exerciseHistory);
        }
      }

      return ris;
    } catch (e) {
      defaultDatabaseErrorDialog(context, e.toString());
      rethrow;
    }
  }
}
