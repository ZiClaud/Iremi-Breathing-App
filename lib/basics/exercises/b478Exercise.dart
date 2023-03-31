import 'package:iremibreathingapp/basics/exercise.dart';

class B478Exercise extends MyExercise {
  @override
  String name = "4-7-8";

  @override
  String description =
      "The 4-7-8 breathing technique can be helpful for reducing stress and promoting relaxation, but it's important to remember that it may not be effective for everyone and should not be used as a substitute for medical treatment for anxiety or other mental health conditions.";

  @override
  String notes =
      "The key is to maintain a steady rhythm and keep the counts accurate.";

  @override
  List<String> steps = [
    "Exhale completely through your mouth, making a whooshing sound.",
    "Close your mouth and inhale quietly through your nose to a mental count of 4.",
    "Hold your breath for a count of 7.",
    "Exhale completely through your mouth, making a whooshing sound to a count of 8.",
    "Immediately inhale again and repeat the cycle three more times for a total of four breaths."
  ];

  @override
  int inhaleTimeMs = 4 * 1000;

  @override
  int holdMiddleTimeMs = 7 * 1000;

  @override
  int exhaleTimeMs = 8 * 1000;

  @override
  int holdEndTimeMs = 1;

  @override
  int times = 4;
}
