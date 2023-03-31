abstract class MyExercise {
  late String name;
  late String description;
  late String notes;
  late List<String> steps;
  late int times;
  late int inhaleTimeMs;
  late int holdMiddleTimeMs;
  late int exhaleTimeMs;
  late int holdEndTimeMs;

  void tellSteps() {
    for (String step in steps) {
      print(step);
    }
  }

  Duration getInhaleDuration() {
    return Duration(milliseconds: inhaleTimeMs);
  }

  Duration getHoldMiddleDuration() {
    return Duration(milliseconds: holdMiddleTimeMs);
  }

  Duration getExhaleDuration() {
    return Duration(milliseconds: exhaleTimeMs);
  }

  Duration getHoldEndDuration() {
    return Duration(milliseconds: holdEndTimeMs);
  }

  Duration getTime() {
    return (getInhaleDuration() +
            getHoldMiddleDuration() +
            getExhaleDuration() +
            getHoldEndDuration()) *
        times;
  }
}
