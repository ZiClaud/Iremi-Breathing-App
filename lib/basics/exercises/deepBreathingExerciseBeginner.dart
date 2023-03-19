import 'package:iremibreathingapp/basics/exercises/deepBreathingExercise.dart';

class DeepBreathingExerciseBeginner extends DeepBreathingExercise {
  @override
  String name = "Deep Breathing Beginner";

  @override
  Duration inhaleDuration = Duration(seconds: 2);

  @override
  Duration holdMiddleDuration = Duration(seconds: 2);

  @override
  Duration exhaleDuration = Duration(seconds: 2);

  @override
  Duration holdEndDuration = Duration(seconds: 2);

  @override
  int times = 5;
}
