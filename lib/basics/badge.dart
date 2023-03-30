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
  /// awarded for completing your first breathing exercise session.
  beginner(0, "Air Apprentice", Icons.air),

  // awarded for consistently completing daily breathing exercises for a week.
  calmAndCollected(1, "Serenity Seeker", Icons.water_drop),

  //  awarded for consistently completing daily breathing exercises for a month.
  healthHero(2, "Wellness Warrior", Icons.local_fire_department),

  // awarded for consistently completing daily breathing exercise for 3 months.
  rockSolid(3, "Rock Solid", Icons.terrain),

  // awarded for practicing deep breathing exercises for more than 5 minutes.
  deepBreather(4, "Deep Breather", Icons.spa),

  // awarded for trying out a all default breathing exercises offered in the app.
  breathingExplorer(5, "Breathing Explorer", Icons.explore),

  // awarded for creating a custom exercise
  customBadge(6, "Customizer", Icons.handyman),

  // awarded for doing 5 exercises between 6AM and 8AM.
  morningPerson(7, "Morning Person", Icons.wb_sunny),

  // awarded for doing 5 exercises between 10PM and 12PM.
  nightOwl(8, "Night Owl", Icons.nightlight_round),

  // awarded for rating the app.
  rater(9, "Rater", Icons.star),

  // awarded for sharing the app with a friend.
  sharingIsCaring(10, "Sharing is Caring", Icons.share),

  // awarded for donating to the app.
  richBoi(11, "Generous Supporter", Icons.attach_money),

  // awarded for backing up your data.
  secure(12, "Backup Master", Icons.save),

  /// awarded for finding a secret page.
  secret(13, "Curious Explorer", Icons.lock_open);

  final int id;
  final String badgeName;
  final IconData icon;

  const PossibleBadges(this.id, this.badgeName, this.icon);
}

class Achievement {
  static PossibleBadges getBadgeByID(int id) {
    return PossibleBadges.values[id];
  }

  static int getMaxID() {
    return PossibleBadges.values.length;
  }

  static Future<void> addAchievement(PossibleBadges badge, context) async {
    try {
      List<MyBadge> badges = await MyDatabase.instance.readAllBadges();
      if (badges.where((element) => element.id == badge.id).isEmpty) {
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
