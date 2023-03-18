abstract class Exercise {
  late String name;
  late String description;
  late String notes;
  late List<String> steps;
  late Duration inhaleTime;
  late Duration holdMiddleTime;
  late Duration exhaleTime;
  late Duration holdEndTime;
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
      await Future.delayed(inhaleTime);
      print('hold');
      await Future.delayed(holdMiddleTime);
      print('exhale');
      await Future.delayed(exhaleTime);
      print('hold');
      await Future.delayed(holdEndTime);
    }
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
