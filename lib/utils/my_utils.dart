import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/exercise.dart';
import 'package:iremibreathingapp/pages/exercise_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'default_widgets.dart';

class MyUtils {
  static String getItalianDateFormat(DateTime dateTime) {
    if (dateTime.day < 10 && dateTime.month < 10) {
      return "0${dateTime.day}/0${dateTime.month}/${dateTime.year}";
    } else if (dateTime.day < 10) {
      return "0${dateTime.day}/${dateTime.month}/${dateTime.year}";
    } else if (dateTime.month < 10) {
      return "${dateTime.day}/0${dateTime.month}/${dateTime.year}";
    }

    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }
}

void navigateToExercisePage(context, MyExercise exercise) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ExercisePage(exercise: exercise),
    ),
  );
}

String getDurationString(MyExercise exercise) {
  return "${exercise.getInhaleDuration().inSeconds}s, ${exercise.getHoldMiddleDuration().inSeconds}s, ${exercise.getExhaleDuration().inSeconds}s, ${exercise.getHoldEndDuration().inSeconds}s";
}

String getAdvancedDurationString(MyExercise exercise) {
  return "${exercise.getInhaleDuration().inSeconds}s ${exercise.getInhaleDuration().inMilliseconds % 1000}ms, ${exercise.getHoldMiddleDuration().inSeconds}s ${exercise.getHoldMiddleDuration().inMilliseconds % 1000}ms, ${exercise.getExhaleDuration().inSeconds}s ${exercise.getExhaleDuration().inMilliseconds % 1000}ms, ${exercise.getHoldEndDuration().inSeconds}s ${exercise.getHoldEndDuration().inMilliseconds % 1000}ms";
}

String getTimeString(MyExercise exercise) {
  if (exercise.getTime().inMinutes != 0 &&
      exercise.getTime().inSeconds % 60 != 0) {
    return "${exercise.getTime().inMinutes}min ${exercise.getTime().inSeconds % 60}s";
  } else if (exercise.getTime().inMinutes != 0 &&
      exercise.getTime().inSeconds % 60 == 0) {
    return "${exercise.getTime().inMinutes}min";
  } else if (exercise.getTime().inMinutes == 0 &&
      exercise.getTime().inSeconds % 60 != 0) {
    return "${exercise.getTime().inSeconds % 60}s";
  } else {
    return "N/A";
  }
}

double getMinWindowSize(context) {
  return math.min((MediaQuery.of(context).size.height),
      (MediaQuery.of(context).size.width) / 2);
}

void printWarning(String text) {
  print('\x1B[33m$text\x1B[0m');
}

void printError(String text) {
  print('\x1B[31m$text\x1B[0m');
}

String getDefaultLanguage() {
  return window.locale.languageCode;
}

ThemeMode _getDefaultTheme() {
  return ThemeMode.system;
}

bool isDefaultThemeDark2() {
  return _getDefaultTheme() == ThemeMode.dark ? true : false;
}

bool isDefaultThemeDark3(context) {
  var brightness = MediaQuery.of(context).platformBrightness;
  return brightness == Brightness.dark;
}

bool isDefaultThemeDark(context) {
  return isDefaultThemeDark2() || isDefaultThemeDark3(context);
}

Future defaultDatabaseErrorDialog(context, String message) {
  print("TODO: IMPORTANT BEFORE RELEASE: Remove comment");
  printWarning("Database error: " + message);
//  throw Exception("TODO: IMPORTANT BEFORE RELEASE: Remove comment");
  return defaultDialog(context, "Database error",
      message); // TODO: IMPORTANT BEFORE RELEASE: Remove comment
}

Future defaultDatabaseErrorDialog2(context, message) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Database error"),
        content: Text(message.toString()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: defaultButtonText("Close"),
          ),
        ],
      );
    },
  );
}

Future defaultDialog(context, String title, String message) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message.toString()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: defaultButtonText("Close"),
          ),
        ],
      );
    },
  );
}

Future<SharedPreferences> getSharedPreferences() async {
  return await SharedPreferences.getInstance();
}
