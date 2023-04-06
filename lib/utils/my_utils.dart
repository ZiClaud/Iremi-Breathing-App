import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:iremibreathingapp/basics/exercise.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isDev = false; //TODO IMPORTANT: Change to false when building for release

/// TTS
FlutterTts flutterTts = FlutterTts();

void setDefaultTTS() {
  setTTS("en-GB");
}

void setTTS(String language) {
  flutterTts.setLanguage(language);
  flutterTts.setPitch(1);
  flutterTts.setSpeechRate(0.8);
  flutterTts.setVolume(0.5);

  flutterTts.setStartHandler(() {
    print("Playing");
  });
  flutterTts.setCompletionHandler(() {
    print("Complete");
  });
  flutterTts.setErrorHandler((msg) {
    print("error: $msg");
  });
}

Future<dynamic> _getTTSLanguages() async => await flutterTts.getLanguages;

Future<List<String>> getAvailableVoiceTypes() async {
  List<String> voiceTypes = [];

  await flutterTts.getLanguages.then((value) {
    voiceTypes.add(value.toString());
  });

  return voiceTypes;
}

Future<String> getDefaultVoiceType() async {
  return (await getAvailableVoiceTypes()).first;
}

List<String> getAvailableVoiceTypes2() {
  return ['Female en-GB', 'en-GB Female'];
}

String getDefaultVoiceType2() {
  return getAvailableVoiceTypes2().first;
}

/// SharedPreferences
Future<SharedPreferences> getSharedPreferences() async {
  return await SharedPreferences.getInstance();
}

/// SharedPreferences default
String _getDefaultLanguageLocale() {
  return window.locale.languageCode;
}

String getDefaultLanguage() {
  if (_getDefaultLanguageLocale() == "en")
    return "English";
  else if (_getDefaultLanguageLocale() == "it")
    return "Italiano";
  else if (_getDefaultLanguageLocale() == "es")
    return "Español";
//  else if (_getDefaultLanguageLocale() == "zh")
//    return "Chinese (Simplified)??";
//  else if (_getDefaultLanguageLocale() == "el")
//    return "Greek??";
  else
    return "English";
}

List<String> getAvailableLanguages() {
  return ['English', 'Italiano', 'Español']; //'Chinese (Simplified)', 'Greek'?
}

/// DarkTheme
ThemeMode _getDefaultTheme() {
  return ThemeMode.system;
}

bool isDefaultThemeDark() {
  // TODO: Maybe change
  return _getDefaultTheme() == ThemeMode.dark ? true : false;
}

/// Date/Time formats
String getItalianDateFormat(DateTime dateTime) {
  if (dateTime.day < 10 && dateTime.month < 10) {
    return "0${dateTime.day}/0${dateTime.month}/${dateTime.year}";
  } else if (dateTime.day < 10) {
    return "0${dateTime.day}/${dateTime.month}/${dateTime.year}";
  } else if (dateTime.month < 10) {
    return "${dateTime.day}/0${dateTime.month}/${dateTime.year}";
  }

  return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
}

String getWeekLetter(DateTime dateTime) {
  dateTime.weekday;

  switch (dateTime.weekday) {
    case 1:
      return "Mon";
    case 2:
      return "Tue";
    case 3:
      return "Wed";
    case 4:
      return "Thu";
    case 5:
      return "Fri";
    case 6:
      return "Sat";
    case 7:
      return "Sun";
    default:
      return "Error";
  }
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

/// Min window size
double getMinWindowSize(context) {
  return math.min((MediaQuery.of(context).size.height),
      (MediaQuery.of(context).size.width) / 2);
}

/// Debug
void printWarning(String text) {
  print('\x1B[33m$text\x1B[0m');
}

void printError(String text) {
  print('\x1B[31m$text\x1B[0m');
}
