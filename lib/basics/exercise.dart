abstract class MyExercise {
  late String name;
  late String description;
  late String notes;
  late List<String> steps;
  late int times;
  late Duration inhaleDuration;
  late Duration holdMiddleDuration;
  late Duration exhaleDuration;
  late Duration holdEndDuration;

  void tellSteps() {
    for (String step in steps) {
      print(step);
    }
  }

  Duration getTime() {
    return (inhaleDuration +
            holdMiddleDuration +
            exhaleDuration +
            holdEndDuration) *
        times;
  }
}
