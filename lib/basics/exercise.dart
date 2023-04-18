import 'package:shared_preferences/shared_preferences.dart';

import '../utils/my_utils.dart';

abstract class MyExercise {
  String name();

  String description();

  String notes();

  List<String> steps();

  int times();

  int inhaleTimeMs();

  int holdMiddleTimeMs();

  int exhaleTimeMs();

  int holdEndTimeMs();

  void tellSteps() {
    for (String step in steps()) {
      print(step);
    }
  }

  Duration getInhaleDuration() {
    return Duration(milliseconds: inhaleTimeMs());
  }

  Duration getHoldMiddleDuration() {
    return Duration(milliseconds: holdMiddleTimeMs());
  }

  Duration getExhaleDuration() {
    return Duration(milliseconds: exhaleTimeMs());
  }

  Duration getHoldEndDuration() {
    return Duration(milliseconds: holdEndTimeMs());
  }

  Duration _getOneLoopDuration() {
    return (getInhaleDuration() +
        getHoldMiddleDuration() +
        getExhaleDuration() +
        getHoldEndDuration());
  }

  Duration getTime() {
    return _getOneLoopDuration() * times();
  }

  Future<void> startTTS() async {
    SharedPreferences prefs = await getSharedPreferences();
    bool voice = prefs.getBool('voice') ?? false;

    if (voice) {
      await flutterTts.awaitSpeakCompletion(false);
      for (String step in steps()) {
        await Future.delayed(_getOneLoopDuration());
        await flutterTts.speak(step);
      }
    }
  }

  Future<void> stopTTS() async {
    SharedPreferences prefs = await getSharedPreferences();
    bool voice = prefs.getBool('voice') ?? false;

    if (voice) {
      flutterTts.stop();
    }
  }
}
