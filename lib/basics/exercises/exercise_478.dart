import 'package:iremibreathingapp/basics/exercise.dart';

class B478Exercise extends MyExercise {
  @override
  String name() {
    return "4-7-8";
  }

  @override
  String description() {
    return "The 4-7-8 breathing technique follows a simple rhythm: inhale for 4 seconds, hold for 7 seconds, and exhale for 8 seconds. This pattern helps slow the heart rate and quiet the mind, making it especially useful for winding down, managing stress, or preparing for sleep.";
  }

  @override
  String notes() {
    return "The key is to maintain a steady rhythm and keep the counts accurate.";
  }

  @override
  List<String> steps() {
    return [
      "Exhale completely through your mouth, making a whooshing sound.",
      "Close your mouth and inhale quietly through your nose to a mental count of 4.",
      "Hold your breath for a count of 7.",
      "Exhale completely through your mouth, making a whooshing sound to a count of 8.",
      "Immediately inhale again and repeat the cycle three more times for a total of four breaths."
    ];
  }

  @override
  int inhaleTimeMs() {
    return 4 * 1000;
  }

  @override
  int holdMiddleTimeMs() {
    return 7 * 1000;
  }

  @override
  int exhaleTimeMs() {
    return 8 * 1000;
  }

  @override
  int holdEndTimeMs() {
    return 1;
  }

  @override
  int times() {
    return 4;
  }
}
