import 'package:flutter/material.dart';

import '../database/database.dart';
import '../utils/myUtils.dart';

class MyBadge {
  final int id;
  final String date;

  const MyBadge({
    required this.id,
    required this.date,
  });

  PossibleBadges getBadge() {
    return PossibleBadges.values[id];
  }

  MyBadge copy({
    int? id,
    String? date,
  }) =>
      MyBadge(
        id: id ?? this.id,
        date: date ?? this.date,
      );

  static MyBadge fromJson(Map<String, Object?> json) => MyBadge(
        id: json[BadgeFields.id] as int,
        date: json[BadgeFields.date] as String,
      );

  Map<String, Object?> toJson() => {
        BadgeFields.id: id,
        BadgeFields.date: date,
      };
}

class BadgeFields {
  static final List<String> values = [id, date];

  static const String id = '_id';
  static const String date = 'date';
}

enum PossibleBadges {
  beginner(0, "Breathing Beginner", Icons.emoji_emotions),
  // awarded for completing your first breathing exercise session.
  calmAndCollected(1, "Calm and Collected", Icons.brightness_3),
  // awarded for consistently completing daily breathing exercises for a set period of time.
  deepBreather(2, "Deep Breather", Icons.local_florist),
  // awarded for practicing deep breathing exercises for a certain amount of time.
  breathingExplorer(3, "Breathing Explorer", Icons.explore),
  // awarded for trying out a variety of different breathing exercises offered in the app.
  stressBuster(4, "Stress Buster", Icons.favorite),
  // awarded for using the app to manage and reduce stress levels.
  richBoi(5, "Rich Boi", Icons.attach_money),
  // awarded for donating to the app.
  rater(6, "Rater", Icons.star),
  // awarded for rating the app.
  sharingIsCaring(7, "Sharing is Caring", Icons.share);
  // awarded for sharing the app with a friend.

  /*
  Mindful Master: awarded for completing a certain number of mindfulness exercises or meditations.
  Focus Achiever: awarded for consistently completing focus and concentration exercises for a set period of time.
  Sleep Savior: awarded for using the app to improve sleep quality and duration.
  Positivity Promoter: awarded for completing a certain number of exercises focused on promoting positive thinking and gratitude.
  Fitness Fanatic: awarded for using the app in conjunction with a fitness routine to enhance physical performance.
  Mood Manager: awarded for using the app to manage and regulate emotions, such as anxiety or anger.
  Health Hero: awarded for consistently using the app to promote overall health and wellness.
   */

//  master("Meditation Master"), // awarded for completing a certain number of meditation sessions.
//  focusedMind("Focused Mind"), // awarded for consistently practicing mindfulness meditation for a set period of time.
//  meditationStreak("Meditation Streak"); // awarded for completing a certain number of consecutive days of meditation.

  final int id;
  final String badgeName;
  final IconData icon;

  const PossibleBadges(this.id, this.badgeName, this.icon);
}

class Achievement {
  static Future<void> addAchievement(PossibleBadges badge, context) async {
    try {
      List<MyBadge> badges = await MyDatabase.instance.readAllBadges();
      if (badges
          .where((element) => element.id == badge.id)
          .isEmpty) {
        _addBadge(badge);
        defaultDialog(context, "New Achievement!", '${badge.badgeName}');
      }
    } catch (e) {
      defaultDatabaseErrorDialog(context, 'Error adding achievement: $e');
      rethrow;
    }
  }

  static void _addBadge(PossibleBadges badge) {
    try {
    MyDatabase.instance.createBadge(MyBadge(
        id: badge.id, date: MyUtils.getItalianDateFormat(DateTime.now())));
    } catch (e) {
      rethrow;
    }
  }
}
