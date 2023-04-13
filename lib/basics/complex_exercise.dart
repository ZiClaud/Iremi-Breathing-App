import 'package:iremibreathingapp/basics/exercise.dart';

class ComplexExercise {
  late List<MyExercise> _exercises;

  int getRounds(){
    return _exercises.length;
  }

  int getTimes(){
    int times = 0;
    for (MyExercise exercise in _exercises) {
      times += exercise.times;
    }
    return times;
  }

  List<MyExercise> get exercises => _exercises;
}
