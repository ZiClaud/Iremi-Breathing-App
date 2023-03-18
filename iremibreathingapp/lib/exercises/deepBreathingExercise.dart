import 'package:iremibreathingapp/exercises/exercise.dart';

abstract class DeepBreathingExercise extends Exercise {
  @override
  List<String> steps = [
    "Find a quiet and comfortable place where you won't be disturbed.",
    "Sit or lie down in a comfortable position with your back straight and your shoulders relaxed.",
    "Place one hand on your chest and the other hand on your belly.",
    "Take a slow, deep breath in through your nose, feeling your belly rise and expand.",
    "Hold your breath for a few seconds.",
    "Exhale slowly through your mouth, feeling your belly fall and contract.",
    "Repeat this process for several minutes, focusing on the sensation of your breath moving in and out of your body."
  ];

}
