import 'package:iremibreathingapp/basics/exercise.dart';

class CustomExercise extends MyExercise {
  final int? id;

  @override
  String name;

  @override
  String description;

  @override
  String notes;

  @override
  List<String> steps;

  @override
  late Duration inhaleDuration;

  @override
  late Duration holdMiddleDuration;

  @override
  late Duration exhaleDuration;

  @override
  late Duration holdEndDuration;

  @override
  int times;

  CustomExercise(
      {this.id,
      required this.name,
      required this.description,
      required this.notes,
      required this.steps,
      required this.times,
      required inhaleTime,
      required holdMiddleTime,
      required exhaleTime,
      required holdEndTime,
      inhaleTimeMs = 0,
      holdMiddleTimeMs = 0,
      exhaleTimeMs = 0,
      holdEndTimeMs = 0}) {
    inhaleDuration =
        Duration(seconds: inhaleTime, milliseconds: inhaleTimeMs);
    holdMiddleDuration =
        Duration(seconds: holdMiddleTime, milliseconds: holdMiddleTimeMs);
    exhaleDuration =
        Duration(seconds: exhaleTime, milliseconds: exhaleTimeMs);
    holdEndDuration =
        Duration(seconds: holdEndTime, milliseconds: holdEndTimeMs);
  }

  CustomExercise copy({
    int? id,
    String? name,
    String? description,
    String? notes,
    List<String>? steps,
    int? times,
    int? inhaleTime,
    int? holdMiddleTime,
    int? exhaleTime,
    int? holdEndTime,
    int? inhaleTimeMs,
    int? holdMiddleTimeMs,
    int? exhaleTimeMs,
    int? holdEndTimeMs,
  }) =>
      CustomExercise(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        notes: notes ?? this.notes,
        steps: steps ?? this.steps,
        times: times ?? this.times,
        inhaleTime: inhaleTime ?? this.inhaleDuration.inSeconds,
        holdMiddleTime: holdMiddleTime ?? this.holdMiddleDuration.inSeconds,
        exhaleTime: exhaleTime ?? this.exhaleDuration.inSeconds,
        holdEndTime: holdEndTime ?? this.holdEndDuration.inSeconds,
        inhaleTimeMs: inhaleTimeMs ?? this.inhaleDuration.inMilliseconds % 1000, // TODO: Check this works properly
        holdMiddleTimeMs:
            holdMiddleTimeMs ?? this.holdMiddleDuration.inMilliseconds % 1000, // TODO: Check this works properly
        exhaleTimeMs: exhaleTimeMs ?? this.exhaleDuration.inMilliseconds % 1000, // TODO: Check this works properly
        holdEndTimeMs: holdEndTimeMs ?? this.holdEndDuration.inMilliseconds % 1000, // TODO: Check this works properly
      );

  static CustomExercise fromJson(Map<String, Object?> json) => CustomExercise(
        id: json[CustomExerciseFields.id] as int?,
        name: json[CustomExerciseFields.name] as String,
        description: json[CustomExerciseFields.description] as String,
        notes: json[CustomExerciseFields.notes] as String,
        steps: json[CustomExerciseFields.steps] as List<String>,
        times: json[CustomExerciseFields.times] as int,
        inhaleTime: json[CustomExerciseFields.inhaleTime] as int,
        holdMiddleTime: json[CustomExerciseFields.holdMiddleTime] as int,
        exhaleTime: json[CustomExerciseFields.exhaleTime] as int,
        holdEndTime: json[CustomExerciseFields.holdEndTime] as int,
        inhaleTimeMs: json[CustomExerciseFields.inhaleTimeMs] as int,
        holdMiddleTimeMs: json[CustomExerciseFields.holdMiddleTimeMs] as int,
        exhaleTimeMs: json[CustomExerciseFields.exhaleTimeMs] as int,
        holdEndTimeMs: json[CustomExerciseFields.holdEndTimeMs] as int,
      );

  Map<String, Object?> toJson() => {
        CustomExerciseFields.id: id,
        CustomExerciseFields.name: name,
        CustomExerciseFields.description: description,
        CustomExerciseFields.notes: notes,
        CustomExerciseFields.steps: steps,
        CustomExerciseFields.times: times,
        CustomExerciseFields.inhaleTime: inhaleDuration.inSeconds,
        CustomExerciseFields.holdMiddleTime: holdMiddleDuration.inSeconds,
        CustomExerciseFields.exhaleTime: exhaleDuration.inSeconds,
        CustomExerciseFields.holdEndTime: holdEndDuration.inSeconds,
        CustomExerciseFields.inhaleTimeMs: inhaleDuration.inMilliseconds % 1000, // TODO: Check this works properly
        CustomExerciseFields.holdMiddleTimeMs: holdMiddleDuration.inMilliseconds % 1000, // TODO: Check this works properly
        CustomExerciseFields.exhaleTimeMs: exhaleDuration.inMilliseconds % 1000, // TODO: Check this works properly
        CustomExerciseFields.holdEndTimeMs: holdEndDuration.inMilliseconds % 1000, // TODO: Check this works properly
      };
}

class CustomExerciseFields {
  static final List<String> values = [
    id,
    name,
    description,
    notes,
    steps,
    times,
    inhaleTime,
    holdMiddleTime,
    exhaleTime,
    holdEndTime,
    inhaleTimeMs,
    holdMiddleTimeMs,
    exhaleTimeMs,
    holdEndTimeMs
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String description = 'description';
  static const String notes = 'notes';
  static const String steps = 'steps';
  static const String times = 'times';
  static const String inhaleTime = 'inhaleDuration';
  static const String holdMiddleTime = 'holdMiddleDuration';
  static const String exhaleTime = 'exhaleDuration';
  static const String holdEndTime = 'holdEndDuration';
  static const String inhaleTimeMs = 'inhaleDuration';
  static const String holdMiddleTimeMs = 'holdMiddleDuration';
  static const String exhaleTimeMs = 'exhaleDuration';
  static const String holdEndTimeMs = 'holdEndDuration';
}
