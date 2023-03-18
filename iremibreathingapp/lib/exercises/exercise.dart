abstract class Exercise {
  late String description;
  late String notes;
  late List<String> steps;
  late double inhaleTime;
  late double holdMiddleTime;
  late double exhaleTime;
  late double holdEndTime;

  void tellSteps() {
    for (String step in steps) {
      print(step);
    }
  }
}
