import 'dart:convert';

class ExerciseHistory {
  final int? id;
  int exerciseDurationSeconds;
  DateTime dateTime;

  Duration _getExerciseDuration() {
    return Duration(seconds: exerciseDurationSeconds);
  }

  DateTime getExerciseTimeStart() {
    return dateTime.subtract(_getExerciseDuration());
  }

  DateTime getExerciseTimeEnd() {
    return dateTime;
  }

  ExerciseHistory(
      {this.id, required this.exerciseDurationSeconds, required this.dateTime});

  copy({
    int? id,
    int? exerciseDurationSeconds,
    DateTime? dateTime,
  }) =>
      ExerciseHistory(
        id: id ?? this.id,
        exerciseDurationSeconds:
            exerciseDurationSeconds ?? this.exerciseDurationSeconds,
        dateTime: dateTime ?? this.dateTime,
      );

  static ExerciseHistory fromJson(Map<String, Object?> json) => ExerciseHistory(
        id: json[ExerciseHistoryFields.id] as int?,
        exerciseDurationSeconds:
            json[ExerciseHistoryFields.exerciseDurationSeconds] as int,
        dateTime:
            DateTime.parse(json[ExerciseHistoryFields.dateTime] as String),
      );

  Map<String, Object?> toJson() => {
        ExerciseHistoryFields.id: id,
        ExerciseHistoryFields.exerciseDurationSeconds: exerciseDurationSeconds,
        ExerciseHistoryFields.dateTime: dateTime.toIso8601String(),
      };

  static ExerciseHistory fromMap(Map<String, dynamic> map) {
    return ExerciseHistory(
      id: map[ExerciseHistoryFields.id],
      exerciseDurationSeconds:
          map[ExerciseHistoryFields.exerciseDurationSeconds],
      dateTime: DateTime.parse(map[ExerciseHistoryFields.dateTime]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ExerciseHistoryFields.id: id,
      ExerciseHistoryFields.exerciseDurationSeconds: exerciseDurationSeconds,
      ExerciseHistoryFields.dateTime: dateTime.toIso8601String(),
    };
  }

  String toJsonString() => json.encode(toJson());

  static ExerciseHistory fromJsonString(String source) =>
      fromJson(json.decode(source));
}

class ExerciseHistoryFields {
  static final List<String> values = [
    id,
    exerciseDurationSeconds,
    dateTime,
  ];

  static const String id = '_id';
  static const String exerciseDurationSeconds = 'exerciseDurationSeconds';
  static const String dateTime = 'dateTime';
}
