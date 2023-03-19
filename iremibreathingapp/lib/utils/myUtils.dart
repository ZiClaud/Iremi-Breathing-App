import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/exercises/exercise.dart';
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

void navigateToExercisePage(context, Exercise exercise) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ExercisePage(exercise: exercise),
    ),
  );
}