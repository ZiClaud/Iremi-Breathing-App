import 'package:iremibreathingapp/basics/exercises/deepBreathingExercise.dart';

class DeepBreathingExerciseBeginner extends DeepBreathingExercise {
  @override
  String name = "Deep Breathing Beginner";

  @override
  Duration inhaleTime = Duration(seconds: 2);

  @override
  Duration holdMiddleTime = Duration(seconds: 2);

  @override
  Duration exhaleTime = Duration(seconds: 2);

  @override
  Duration holdEndTime = Duration(seconds: 2);

  @override
  int times = 5;
}
