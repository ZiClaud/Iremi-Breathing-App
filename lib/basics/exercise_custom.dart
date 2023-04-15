import 'package:iremibreathingapp/basics/exercise.dart';

class CustomExercise extends MyExercise {
  final int? id;

  String name2;
  String description2;
  String notes2;
  List<String> steps2;
  int inhaleTimeMs2;
  int holdMiddleTimeMs2;
  int exhaleTimeMs2;
  int holdEndTimeMs2;
  int times2;

  @override
  String name() {
    return name2;
  }

  @override
  String description() {
    return description2;
  }

  @override
  String notes() {
    return notes2;
  }

  @override
  List<String> steps() {
    return steps2;
  }

  @override
  int times() {
    return times2;
  }

  @override
  int inhaleTimeMs() {
    return inhaleTimeMs2;
  }

  @override
  int holdMiddleTimeMs() {
    return holdMiddleTimeMs2;
  }

  @override
  int exhaleTimeMs() {
    return exhaleTimeMs2;
  }

  @override
  int holdEndTimeMs() {
    return holdEndTimeMs2;
  }

  CustomExercise(
      {this.id,
      required this.name2,
      required this.description2,
      required this.notes2,
      required this.steps2,
      required this.times2,
      required this.inhaleTimeMs2,
      required this.holdMiddleTimeMs2,
      required this.exhaleTimeMs2,
      required this.holdEndTimeMs2});

  CustomExercise copy({
    int? id,
    String? name2,
    String? description2,
    String? notes2,
    List<String>? steps2,
    int? times2,
    int? inhaleTimeMs2,
    int? holdMiddleTimeMs2,
    int? exhaleTimeMs2,
    int? holdEndTimeMs2,
  }) {
    return CustomExercise(
      id: id ?? this.id,
      name2: name2 ?? this.name2,
      description2: description2 ?? this.description2,
      notes2: notes2 ?? this.notes2,
      steps2: steps2 ?? this.steps2,
      times2: times2 ?? this.times2,
      inhaleTimeMs2: inhaleTimeMs2 ?? this.inhaleTimeMs2,
      holdMiddleTimeMs2: holdMiddleTimeMs2 ?? this.holdMiddleTimeMs2,
      exhaleTimeMs2: exhaleTimeMs2 ?? this.exhaleTimeMs2,
      holdEndTimeMs2: holdEndTimeMs2 ?? this.holdEndTimeMs2,
    );
  }

  static CustomExercise fromJson(Map<String, Object?> json) => CustomExercise(
        id: json[CustomExerciseFields.id] as int?,
        name2: json[CustomExerciseFields.name2] as String,
        description2: json[CustomExerciseFields.description2] as String,
        notes2: json[CustomExerciseFields.notes2] as String,
        steps2: (json[CustomExerciseFields.steps2] as String)
            .split(',')
            .map((step) => step.trim())
            .toList(),
        times2: json[CustomExerciseFields.times2] as int,
        inhaleTimeMs2: json[CustomExerciseFields.inhaleTimeMs2] as int,
        holdMiddleTimeMs2: json[CustomExerciseFields.holdMiddleTimeMs2] as int,
        exhaleTimeMs2: json[CustomExerciseFields.exhaleTimeMs2] as int,
        holdEndTimeMs2: json[CustomExerciseFields.holdEndTimeMs2] as int,
      );

  Map<String, Object?> toJson() => {
        CustomExerciseFields.id: id,
        CustomExerciseFields.name2: name2,
        CustomExerciseFields.description2: description2,
        CustomExerciseFields.notes2: notes2,
        CustomExerciseFields.steps2: steps2,
        CustomExerciseFields.times2: times2,
        CustomExerciseFields.inhaleTimeMs2: inhaleTimeMs2,
        CustomExerciseFields.holdMiddleTimeMs2: holdMiddleTimeMs2,
        CustomExerciseFields.exhaleTimeMs2: exhaleTimeMs2,
        CustomExerciseFields.holdEndTimeMs2: holdEndTimeMs2,
      };
}

class CustomExerciseFields {
  static final List<String> values = [
    id,
    name2,
    description2,
    notes2,
    steps2,
    times2,
    inhaleTimeMs2,
    holdMiddleTimeMs2,
    exhaleTimeMs2,
    holdEndTimeMs2
  ];

  static const String id = '_id';
  static const String name2 = 'name';
  static const String description2 = 'description';
  static const String notes2 = 'notes';
  static const String steps2 = 'steps';
  static const String times2 = 'times';
  static const String inhaleTimeMs2 = 'inhaleTimeMs';
  static const String holdMiddleTimeMs2 = 'holdMiddleTimeMs';
  static const String exhaleTimeMs2 = 'exhaleTimeMs';
  static const String holdEndTimeMs2 = 'holdEndTimeMs';
}
