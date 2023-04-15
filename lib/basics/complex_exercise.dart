import 'package:iremibreathingapp/basics/exercise.dart';

abstract class ComplexExercise extends MyExercise {
  List<MyExercise> _exercises();

  int getRounds() {
    return _exercises().length;
  }

  int getTimes() {
    int times = 0;
    for (MyExercise exercise in _exercises()) {
      times += exercise.times();
    }
    return times;
  }

  List<MyExercise> get exercises => _exercises();
}
