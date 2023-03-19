import 'package:iremibreathingapp/basics/exercises/deepBreathingExercise.dart';

class DeepBreathingExerciseAvanced extends DeepBreathingExercise {
  @override
  String name = "Deep Breathing Avanced";

  @override
  Duration inhaleDuration = Duration(seconds: 4);

  @override
  Duration holdMiddleDuration = Duration(seconds: 4);

  @override
  Duration exhaleDuration = Duration(seconds: 4);

  @override
  Duration holdEndDuration = Duration(seconds: 4);

  @override
  int times = 30;
}
