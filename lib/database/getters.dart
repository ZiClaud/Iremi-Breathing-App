import 'package:iremibreathingapp/basics/exercise.dart';
import 'package:iremibreathingapp/basics/exercise_custom.dart';
import 'package:iremibreathingapp/basics/exercise_history.dart';
import 'package:iremibreathingapp/basics/exercises/exercise_478.dart';
import 'package:iremibreathingapp/basics/exercises/exercise_box_breathing.dart';
import 'package:iremibreathingapp/basics/exercises/exercise_deep_breathing_beginner.dart';
import 'package:iremibreathingapp/basics/user.dart';
import 'package:iremibreathingapp/utils/my_utils.dart';

import '../basics/badge.dart';
import '../basics/exercises/exercise_deep_breathing_avanced.dart';
import '../basics/exercises/exercise_deep_breathing_intermediate.dart';
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
    // TODO: Change with user's language
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
      List<ExerciseHistory?> val =
          await DBExerciseHistory().readAllExerciseHistory();
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
