import 'package:iremibreathingapp/basics/exercise.dart';

abstract class ComplexExercise extends MyExercise {
  List<ComplexExerciseItem> exercises();

  int rounds();

  int getNumberOfExercises() {
    return exercises().length;
  }

  @override
  List<String> steps() {
    List<String> steps = [];
    for (MyExercise exercise in exercises()) {
      steps.addAll(exercise.steps());
    }
    return steps;
  }

  @override
  int times() {
    int times = 0;
    for (MyExercise exercise in exercises()) {
      times += exercise.times();
    }
    return times;
  }

  @override
  Duration getTime() {
    Duration time = Duration.zero;
    for (MyExercise exercise in exercises()) {
      time += exercise.getTime();
    }
    return time;
  }

  @override
  int exhaleTimeMs() {
    // TODO: Throw unimplemented exception - throw UnimplementedError();
    return 1;
  }

  @override
  int holdEndTimeMs() {
    // TODO: Throw unimplemented exception - throw UnimplementedError();
    return 1;
  }

  @override
  int holdMiddleTimeMs() {
    // TODO: Throw unimplemented exception - throw UnimplementedError();
    return 1;
  }

  @override
  int inhaleTimeMs() {
    // TODO: Throw unimplemented exception - throw UnimplementedError();
    return 1;
  }
}

abstract class ComplexExerciseItem extends MyExercise {
  @override
  String description() {
    throw UnimplementedError();
  }

  @override
  String notes() {
    throw UnimplementedError();
  }
}
