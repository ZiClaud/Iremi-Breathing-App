import 'package:iremibreathingapp/basics/exercises/deepBreathingExercise.dart';

class DeepBreathingExerciseIntermediate extends DeepBreathingExercise {
  @override
  String name = "Deep Breathing Intermediate";

  @override
  Duration inhaleDuration = const Duration(seconds: 4);

  @override
  Duration holdMiddleDuration = const Duration(seconds: 4);

  @override
  Duration exhaleDuration = const Duration(seconds: 4);

  @override
  Duration holdEndDuration = const Duration(seconds: 4);

  @override
  int times = 10;
}
