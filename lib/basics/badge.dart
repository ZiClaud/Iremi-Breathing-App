import 'package:achievement_view/achievement_view.dart';
import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/exercise_history.dart';
import 'package:iremibreathingapp/database/getters.dart';
import 'package:iremibreathingapp/utils/theme.dart';

import '../database/database.dart';
import '../utils/my_utils.dart';

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
  airApprentice(0, "Air Apprentice", Icons.air),

  /// awarded for consistently completing breathing exercises daily for a week.
  serenitySeeker(1, "Serenity Seeker", Icons.water_drop),

  ///  awarded for consistently completing breathing exercises daily for a month.
  wellnessWarrior(2, "Wellness Warrior", Icons.local_fire_department),

  /// awarded for consistently completing breathing exercises daily for 3 months.
  rockSolid(3, "Rock Solid", Icons.terrain),

  /// awarded for practicing deep breathing exercises for more than 5 minutes.
  deepBreather(4, "Deep Breather", Icons.spa),

  // awarded for trying out a all default breathing exercises offered in the app.
  breathingExplorer(5, "Breathing Explorer", Icons.explore),

  /// awarded for creating a custom exercise
  customizer(6, "Customizer", Icons.handyman),

  /// awarded for doing 5 exercises between 6AM and 8AM.
  morningPerson(7, "Morning Person", Icons.wb_sunny),

  /// awarded for doing 5 exercises between 10PM and 12PM.
  nightOwl(8, "Night Owl", Icons.nightlight_round),

  // awarded for rating the app.
  rater(9, "Rater", Icons.star),

  // awarded for sharing the app with a friend.
  sharingIsCaring(10, "Sharing is Caring", Icons.share),

  // awarded for donating to the app.
  supporter(11, "Generous Supporter", Icons.attach_money),

  /// awarded for backing up your data.
  backupMaster(12, "Backup Master", Icons.save),

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
      List<MyBadge> badges = await DBMyBadge().readAllBadges();
      if (badges.where((element) => element.id == badge.id).isEmpty) {
        _addBadge(badge);
        _showAchievementView(context, badge);
      }
    } catch (e) {
      defaultDatabaseErrorDialog(context, 'Error adding achievement: $e');
      rethrow;
    }
  }

  static Future<void> checkExerciseHistoryAchievement(context) async {
    List<ExerciseHistory> exerciseHistory =
        await Getters.getExerciseHistoryDB(context);

    int streak = _getExerciseHistoryStreak(exerciseHistory);
    int morningPerson = _getExerciseHistoryMorningTimes(exerciseHistory);
    int nightOwl = _getExerciseHistoryNightTimes(exerciseHistory);

    if (streak >= 7) {
      addAchievement(PossibleBadges.serenitySeeker, context);
    }
    if (streak >= 30) {
      addAchievement(PossibleBadges.wellnessWarrior, context);
    }
    if (streak >= 90) {
      addAchievement(PossibleBadges.rockSolid, context);
    }
    if (morningPerson >= 5) {
      addAchievement(PossibleBadges.morningPerson, context);
    }
    if (nightOwl >= 5) {
      addAchievement(PossibleBadges.nightOwl, context);
    }
  }

  static int _getExerciseHistoryStreak(List<ExerciseHistory> exerciseHistory) {
    int streak = 0;
    DateTime? date;

    for (ExerciseHistory exercise in exerciseHistory) {
      if (date != null && date.difference(exercise.dateTime).inDays == -1) {
        streak++;
      } else {
        streak = 0;
      }

      date = exercise.dateTime;
    }

    if (date != null && date.difference(DateTime.now()).inDays == -1) {
      streak++;
    } else {
      streak = 0;
    }

    return streak;
  }

  static int _getExerciseHistoryMorningTimes(
      List<ExerciseHistory> exerciseHistory) {
    int morningPerson = 0;
    DateTime? lastMorningDate;

    for (ExerciseHistory exercise in exerciseHistory) {
      if (exercise.dateTime.hour > 6 && exercise.dateTime.hour < 8) {
        if (lastMorningDate == null ||
            exercise.dateTime.isAfter(lastMorningDate)) {
          morningPerson++;
          lastMorningDate = exercise.dateTime;
        }
      }
    }

    return morningPerson;
  }

  static int _getExerciseHistoryNightTimes(
      List<ExerciseHistory> exerciseHistory) {
    int nightOwl = 0;
    DateTime? lastMorningDate;

    for (ExerciseHistory exercise in exerciseHistory) {
      if (exercise.dateTime.hour > 22 && exercise.dateTime.hour < 24) {
        if (lastMorningDate == null ||
            exercise.dateTime.isAfter(lastMorningDate)) {
          nightOwl++;
          lastMorningDate = exercise.dateTime;
        }
      }
    }

    return nightOwl;
  }

  static void _showAchievementView(BuildContext context, PossibleBadges badge) {
    AchievementView(
      context,
      title: "New Achievement!",
      subTitle: badge.badgeName,
      icon: Icon(badge.icon, color: Colors.white),
      color: myBluNeutral,
      isCircle: true,
    ).show();
  }

  static void _addBadge(PossibleBadges badge) {
    try {
      DBMyBadge().createBadge(
          MyBadge(id: badge.id, date: getItalianDateFormat(DateTime.now())));
    } catch (e) {
      rethrow;
    }
  }
}
