import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/exercise.dart';
import 'package:iremibreathingapp/pages/exercisePage.dart';

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
  return "${exercise.inhaleDuration.inSeconds}s, ${exercise.holdMiddleDuration.inSeconds}s, ${exercise.exhaleDuration.inSeconds}s, ${exercise.holdEndDuration.inSeconds}s";
}

String getAdvancedDurationString(MyExercise exercise) {
  return "${exercise.inhaleDuration.inSeconds}s ${exercise.inhaleDuration.inMilliseconds % 1000}ms, ${exercise.holdMiddleDuration.inSeconds}s ${exercise.holdMiddleDuration.inMilliseconds % 1000}ms, ${exercise.exhaleDuration.inSeconds}s ${exercise.exhaleDuration.inMilliseconds % 1000}ms, ${exercise.holdEndDuration.inSeconds}s ${exercise.holdEndDuration.inMilliseconds % 1000}ms";
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
  return math.min(MediaQuery.of(context).size.height,
          MediaQuery.of(context).size.width) /
      2;
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

bool getDefaultTheme2() {
  return _getDefaultTheme() == ThemeMode.dark ? true : false;
}

bool getDefaultTheme3(context) {
  var brightness = MediaQuery.of(context).platformBrightness;
  return brightness == Brightness.dark;
}

bool getDefaultTheme(context) {
  return getDefaultTheme2() || getDefaultTheme3(context);
}

Future defaultDatabaseErrorDialog(context, message) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Database error"),
        content: Text(message.toString()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Close"),
          ),
        ],
      );
    },
  );
}