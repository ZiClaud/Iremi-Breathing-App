import 'package:iremibreathingapp/basics/exercise.dart';

abstract class ComplexExercise extends MyExercise {
  List<ComplexExerciseItem> _exercises();

  int getRounds() {
    return _exercises().length;
  }

  List<ComplexExerciseItem> get exercises => _exercises();

  @override
  Duration getTime() {
    throw UnimplementedError();
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