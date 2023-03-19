abstract class Exercise {
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

  void start() {
    start2(times);
  }

  void start2(int times) async {
    while (times-- > 0) {
      print('inhale');
      await Future.delayed(inhaleDuration);
      print('hold');
      await Future.delayed(holdMiddleDuration);
      print('exhale');
      await Future.delayed(exhaleDuration);
      print('hold');
      await Future.delayed(holdEndDuration);
    }
  }

  Duration getTime(){
    return (inhaleDuration + holdMiddleDuration + exhaleDuration + holdEndDuration) * times;
  }

/*
  void start2(int times) { // TODO: Put Async somewhere
    if (times > 0) {
      print('inhale');
      Future.delayed(inhaleTime, () {
        print('hold');
        Future.delayed(holdMiddleTime, () {
          print('exhale');
          Future.delayed(exhaleTime, () {
            print('hold');
            Future.delayed(holdEndTime, () {
              start2(times - 1);
            });
          });
        });
      });
    }
  }
 */
}
