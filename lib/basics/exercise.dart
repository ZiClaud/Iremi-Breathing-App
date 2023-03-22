abstract class MyExercise {
  late String name;
  late String description;
  late String notes;
  late List<String> steps;
  late Duration inhaleDuration;
  late Duration holdMiddleDuration;
  late Duration exhaleDuration;
  late Duration holdEndDuration;
  late int times;

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
/*
  void start() {
    start2(times);
  }

  void start2(int times) async {
    while (times > 0) {
      print('inhale');
      await Future.delayed(inhaleDuration);
      print('hold');
      await Future.delayed(holdMiddleDuration);
      print('exhale');
      await Future.delayed(exhaleDuration);
      print('hold');
      await Future.delayed(holdEndDuration);
      times--;
    }
  }
  */