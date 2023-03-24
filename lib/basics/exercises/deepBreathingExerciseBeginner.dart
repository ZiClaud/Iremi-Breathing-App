import 'package:iremibreathingapp/basics/exercises/deepBreathingExercise.dart';

class DeepBreathingExerciseBeginner extends DeepBreathingExercise {
  @override
  String name = "Deep Breathing Beginner";

  @override
  Duration inhaleDuration = const Duration(seconds: 2);

  @override
  Duration holdMiddleDuration = const Duration(seconds: 2);

  @override
  Duration exhaleDuration = const Duration(seconds: 2);

  @override
  Duration holdEndDuration = const Duration(seconds: 2);

  @override
  int times = 5;
}
