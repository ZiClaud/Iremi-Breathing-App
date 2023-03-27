/*
class MyBadge {
  final int? id;
  List<String> badges;

  MyBadge({this.id, required this.badges});
}
*/
enum MyBadge {
  beginner("Breathing Beginner"), // awarded for completing your first breathing exercise session.
  calmAndCollected("Calm and Collected"), // awarded for consistently completing daily breathing exercises for a set period of time.
  deepBreather("Deep Breather"), // awarded for practicing deep breathing exercises for a certain amount of time.
  breathingExplorer("Breathing Explorer"), // awarded for trying out a variety of different breathing exercises offered in the app.
  stressBuster("Stress Buster"); // awarded for using the app to manage and reduce stress levels.


//  master("Meditation Master"), // awarded for completing a certain number of meditation sessions.
//  focusedMind("Focused Mind"), // awarded for consistently practicing mindfulness meditation for a set period of time.
//  meditationStreak("Meditation Streak"); // awarded for completing a certain number of consecutive days of meditation.


  final String value;

  const MyBadge(this.value);
}