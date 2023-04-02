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
  int inhaleTimeMs;

  @override
  int holdMiddleTimeMs;

  @override
  int exhaleTimeMs;

  @override
  int holdEndTimeMs;

  @override
  int times;

  CustomExercise(
      {this.id,
      required this.name,
      required this.description,
      required this.notes,
      required this.steps,
      required this.times,
      required this.inhaleTimeMs,
      required this.holdMiddleTimeMs,
      required this.exhaleTimeMs,
      required this.holdEndTimeMs});

  CustomExercise copy({
    int? id,
    String? name,
    String? description,
    String? notes,
    List<String>? steps,
    int? times,
    int? inhaleTimeMs,
    int? holdMiddleTimeMs,
    int? exhaleTimeMs,
    int? holdEndTimeMs,
  }) {
    return CustomExercise(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      notes: notes ?? this.notes,
      steps: steps ?? this.steps,
      times: times ?? this.times,
      inhaleTimeMs: inhaleTimeMs ?? this.inhaleTimeMs,
      holdMiddleTimeMs: holdMiddleTimeMs ?? this.holdMiddleTimeMs,
      exhaleTimeMs: exhaleTimeMs ?? this.exhaleTimeMs,
      holdEndTimeMs: holdEndTimeMs ?? this.holdEndTimeMs,
    );
  }

  static CustomExercise fromJson(Map<String, Object?> json) => CustomExercise(
        id: json[CustomExerciseFields.id] as int?,
        name: json[CustomExerciseFields.name] as String,
        description: json[CustomExerciseFields.description] as String,
        notes: json[CustomExerciseFields.notes] as String,
        steps: (json[CustomExerciseFields.steps] as String)
            .split(',')
            .map((step) => step.trim())
            .toList(),
        times: json[CustomExerciseFields.times] as int,
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
        CustomExerciseFields.inhaleTimeMs: inhaleTimeMs,
        CustomExerciseFields.holdMiddleTimeMs: holdMiddleTimeMs,
        CustomExerciseFields.exhaleTimeMs: exhaleTimeMs,
        CustomExerciseFields.holdEndTimeMs: holdEndTimeMs,
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
  static const String inhaleTimeMs = 'inhaleTimeMs';
  static const String holdMiddleTimeMs = 'holdMiddleTimeMs';
  static const String exhaleTimeMs = 'exhaleTimeMs';
  static const String holdEndTimeMs = 'holdEndTimeMs';
}
