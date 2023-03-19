import 'package:iremibreathingapp/basics/exercises/exercise.dart';

class BoxBreathingExercise extends Exercise {
  @override
  String name = "Box Breathing";

  @override
  String description =
      "Also known as square breathing, this involves inhaling for four seconds, holding the breath for four seconds, exhaling for four seconds, and then holding the breath for another four seconds.";

  @override
  String notes =
      "Box breathing can be a helpful tool for managing stress and anxiety, promoting relaxation, and improving focus and mental clarity. It can be practiced anywhere and anytime, and is often used by athletes, military personnel, and performers to manage nerves and maintain a sense of calm under pressure. However, if you experience any discomfort or dizziness while practicing box breathing, you should stop immediately and try a different breathing technique or seek medical attention if necessary.";

  @override
  List<String> steps = [
    "Sit or lie down in a comfortable position",
    "Take a slow, deep breath through your nose, filling your lungs completely with air. Count to four as you inhale.",
    "Hold your breath for a count of four.",
    "Exhale slowly through your mouth for a count of four, completely emptying your lungs.",
    "Hold your breath for a count of four.",
    "Repeat the cycle several times, aiming for a consistent, even rhythm."
  ];

  @override
  Duration inhaleDuration = Duration(seconds: 4);

  @override
  Duration holdMiddleDuration = Duration(seconds: 4);

  @override
  Duration exhaleDuration = Duration(seconds: 4);

  @override
  Duration holdEndDuration = Duration(seconds: 4);

  @override
  int times = 4;
}
