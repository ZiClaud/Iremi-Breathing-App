import 'package:iremibreathingapp/basics/complex_exercise.dart';

import '../exercise.dart';

class WimHofMethodExercise extends ComplexExercise {
  @override
  late List<MyExercise> _exercises = [
    _WimHofMethodExercisePt1(),
    _WimHofMethodExercisePt2(),
    _WimHofMethodExercisePause(),
    _WimHofMethodExercisePt3(),
    _WimHofMethodExercisePt4(),
    _WimHofMethodExercisePause(),
    _WimHofMethodExercisePt5(),
    _WimHofMethodExercisePt6(),
  ];
}

class _WimHofMethodExercisePause extends MyExercise {
  @override
  late String name = "Pause";

  @override
  late List<String> steps = [];

  @override
  late int times = 1;

  @override
  late int inhaleTimeMs = 3000;

  @override
  late int holdMiddleTimeMs = 15000;

  @override
  late int exhaleTimeMs = 3000;

  @override
  late int holdEndTimeMs = 1000;
}

class _WimHofMethodExercisePt1 extends MyExercise {
  @override
  late String name = "Wim Hof Method - Part 1";

  @override
  late String description =
      "This is the first part of the Wim Hof Method. It is a breathing exercise that will help you to relax and to get rid of stress.";

  @override
  late String notes =
      "People with certain medical conditions such as asthma, epilepsy, and high blood pressure should avoid this practice or seek medical advice before trying it.";

  @override
  late List<String> steps = [
    "Round number one.",
    "Breathe in. Breathe out.",
    "Just go with the flow of the breath.",
    "In. Out. In. Out.",
    "Into the belly. Into the chest. And let go.",
    "Like a wave. Make it circular.",
    "Fully in. Letting go.",
    "Just keep on going.",
    "No pause between inhalation and exhalation.",
    "Fully in. Letting go.",
  ];

  @override
  late int times = 30;

  @override
  late int inhaleTimeMs = 1562;

  @override
  late int holdMiddleTimeMs = 1;

  @override
  late int exhaleTimeMs = 1562;

  @override
  late int holdEndTimeMs = 1;
}

class _WimHofMethodExercisePt2 extends MyExercise {
  @override
  late String name = "Wim Hof Method - Part 2";

  @override
  late List<String> steps = [
    "One minute breath hold from now on.",
    "Be in this moment.",
    "Let the body do what the body is capable of doing.",
    "Be aware of your heartbeat. Slow it down, and just be in this moment.",
    "Let that relaxation spread down to your toes, into your fingertips, to the base of your neck and head.",
  ];

  @override
  late int times = 1;

  @override
  late int inhaleTimeMs = 1;

  @override
  late int holdMiddleTimeMs = 1;

  @override
  late int exhaleTimeMs = 1;

  @override
  late int holdEndTimeMs = 60000;
}

class _WimHofMethodExercisePt3 extends MyExercise {
  @override
  late String name = "Wim Hof Method - Part 3";

  @override
  late List<String> steps = [
    "Back into that rhythm.",
    "Breathe in, Breathe out. Breathe in. Breathe out.",
    "In. Out. In. Out. In. Out.",
    "Into the belly, Into the chest, and let go.",
    "Like a wave. Make it circular.",
    "Fully in. Letting go.",
    "Just keep on going.",
    "No pause between inhalation and exhalation.",
    "In with peace. Out with stress",
    "Fully in. Letting go.",
    "Nice deep circular breaths.",
  ];

  @override
  late int times = 30;

  @override
  late int inhaleTimeMs = 1562;

  @override
  late int holdMiddleTimeMs = 1;

  @override
  late int exhaleTimeMs = 1562;

  @override
  late int holdEndTimeMs = 1;
}

class _WimHofMethodExercisePt4 extends MyExercise {
  @override
  late String name = "Wim Hof Method - Part 4";

  @override
  late List<String> steps = [
    "One a half minute breath hold from now on.",
    "Feel. Become aware of your body.",
    "If your hands and feet are tingling or you feel your body temperature is changing, that's ok.",
    "You're doing fantastic.",
    "If you need to breathe before I give the cue, that's okay",
  ];

  @override
  late int times = 1;

  @override
  late int inhaleTimeMs = 1;

  @override
  late int holdMiddleTimeMs = 1;

  @override
  late int exhaleTimeMs = 1;

  @override
  late int holdEndTimeMs = 90000;
}

class _WimHofMethodExercisePt5 extends MyExercise {
  @override
  late String name = "Wim Hof Method - Part 5";

  @override
  late List<String> steps = [
    "Round number three.",
    "Back into that rhythm.",
    "Breathe in. Breathe out. Breathe in. Breathe out.",
    "In with the relaxation. Out with the stress.",
    "In . Out. In. Out. In. Out.",
    "Into the belly, into the chest, and let go.",
    "Like a wave. Make it circular.",
    "Fully in. Letting go.",
    "Just keep on going.",
    "No pause between inhalation and exhalation.",
    "In with peace Out with stress.",
    "Fully in. Letting go.",
    "Nice deep circular breaths.",
  ];

  @override
  late int times = 30;

  @override
  late int inhaleTimeMs = 1562;

  @override
  late int holdMiddleTimeMs = 1;

  @override
  late int exhaleTimeMs = 1562;

  @override
  late int holdEndTimeMs = 1;
}

class _WimHofMethodExercisePt6 extends MyExercise {
  @override
  late String name = "Wim Hof Method - Part 6";

  @override
  late List<String> steps = [
    "One and a half minute breath hold from now on.",
    "Become aware of the blood running through your veins, your heart beating. Feel.",
    "You are almost there.",
  ];

  @override
  late int times = 1;

  @override
  late int inhaleTimeMs = 1;

  @override
  late int holdMiddleTimeMs = 1;

  @override
  late int exhaleTimeMs = 1;

  @override
  late int holdEndTimeMs = 90000;
}
