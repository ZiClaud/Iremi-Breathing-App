import 'package:iremibreathingapp/basics/exercises/deepBreathingExercise.dart';

class DeepBreathingExerciseIntermediate extends DeepBreathingExercise {
  @override
  String name = "Deep Breathing Intermediate";

  @override
  Duration inhaleTime = Duration(seconds: 4);

  @override
  Duration holdMiddleTime = Duration(seconds: 4);

  @override
  Duration exhaleTime = Duration(seconds: 4);

  @override
  Duration holdEndTime = Duration(seconds: 4);

  @override
  int times = 5;
}
