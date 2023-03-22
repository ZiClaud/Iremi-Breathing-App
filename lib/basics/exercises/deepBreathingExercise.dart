import 'package:iremibreathingapp/basics/exercise.dart';

abstract class DeepBreathingExercise extends MyExercise {
  @override
  String name = "Deep Breathing";

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

  @override
  String description =
      "Also known as diaphragmatic breathing or belly breathing, involves taking slow, deep breaths through your nose and filling your lungs completely with air, allowing your abdomen to expand and contract with each inhale and exhale. It's a natural way of breathing that can help to calm the mind and body, reduce stress and anxiety, and promote relaxation.";

  @override
  String notes =
      "Deep breathing can be done for as long as you like, but it's often recommended to start with five to ten minutes of practice and gradually increase the duration as you become more comfortable with the technique. You can practice deep breathing several times a day, whenever you feel stressed or anxious, or as a daily relaxation practice.";
}
