import 'package:iremibreathingapp/basics/exercise.dart';

abstract class ComplexExercise extends MyExercise {
  List<ComplexExerciseItem> _exercises();

  int getRounds() {
    return _exercises().length;
  }

  List<ComplexExerciseItem> get exercises => _exercises();

  @override
  List<String> steps() {
    List<String> steps = [];
    for (MyExercise exercise in _exercises()) {
      steps.addAll(exercise.steps());
    }
    return steps;
  }

  @override
  int times() {
    int times = 0;
    for (MyExercise exercise in _exercises()) {
      times += exercise.times();
    }
    return times;
  }

  @override
  int exhaleTimeMs() {
    throw UnimplementedError();
  }

  @override
  int holdEndTimeMs() {
    throw UnimplementedError();
  }

  @override
  int holdMiddleTimeMs() {
    throw UnimplementedError();
  }

  @override
  int inhaleTimeMs() {
    throw UnimplementedError();
  }
}

abstract class ComplexExerciseItem extends MyExercise{
  @override
  String description() {
    throw UnimplementedError();
  }

  @override
  String notes() {
    throw UnimplementedError();
  }
}