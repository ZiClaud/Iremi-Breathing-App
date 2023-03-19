import 'package:iremibreathingapp/exercises/deepBreathingExercise.dart';

class DeepBreathingExerciseIntermediate extends DeepBreathingExercise {
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
