import 'package:flutter/material.dart';

class MyBadge {
  final int id;
  final String date;

  const MyBadge({
    required this.id,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
    };
  }

  PossibleBadges getBadge() {
    return PossibleBadges.values[id];
  }
}


enum PossibleBadges {
  beginner(0, "Breathing Beginner", Icons.star), // awarded for completing your first breathing exercise session.
  calmAndCollected(1, "Calm and Collected", Icons.star), // awarded for consistently completing daily breathing exercises for a set period of time.
  deepBreather(2, "Deep Breather", Icons.star), // awarded for practicing deep breathing exercises for a certain amount of time.
  breathingExplorer(3, "Breathing Explorer", Icons.star), // awarded for trying out a variety of different breathing exercises offered in the app.
  stressBuster(4, "Stress Buster", Icons.star), // awarded for using the app to manage and reduce stress levels.
  richBoi(5, "Rich Boi", Icons.wallet); // awarded for donating to the app.
  
//  master("Meditation Master"), // awarded for completing a certain number of meditation sessions.
//  focusedMind("Focused Mind"), // awarded for consistently practicing mindfulness meditation for a set period of time.
//  meditationStreak("Meditation Streak"); // awarded for completing a certain number of consecutive days of meditation.

  final int? id;
  final String badgeName;
  final IconData icon;

  const PossibleBadges(this.id, this.badgeName, this.icon);
}
