import 'package:iremibreathingapp/basics/complex_exercise.dart';

class WimHofMethodExercise extends ComplexExercise {
  @override
  List<ComplexExerciseItem> _exercises() {
    return [
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

  @override
  String name() {
    return "Wim Hof Method";
  }

  @override
  String description() {
    return "It is a breathing exercise that will help you to relax and to get rid of stress.";
  }

  @override
  String notes() {
    return "People with certain medical conditions such as asthma, epilepsy, and high blood pressure should avoid this practice or seek medical advice before trying it.";
  }
}

class _WimHofMethodExercisePause extends ComplexExerciseItem {
  @override
  String name() {
    return "Pause";
  }

  @override
  List<String> steps() {
    return [];
  }

  @override
  int times() {
    return 1;
  }

  @override
  int inhaleTimeMs() {
    return 3000;
  }

  @override
  int holdMiddleTimeMs() {
    return 15000;
  }

  @override
  int exhaleTimeMs() {
    return 3000;
  }

  @override
  int holdEndTimeMs() {
    return 1000;
  }
}

class _WimHofMethodExercisePt1 extends ComplexExerciseItem {
  @override
  String name() {
    return "Wim Hof Method - Part 1";
  }

  @override
  List<String> steps() {
    return [
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
  }

  @override
  int times() {
    return 30;
  }

  @override
  int inhaleTimeMs() {
    return 1562;
  }

  @override
  int holdMiddleTimeMs() {
    return 1;
  }

  @override
  int exhaleTimeMs() {
    return 1562;
  }

  @override
  int holdEndTimeMs() {
    return 1;
  }
}

class _WimHofMethodExercisePt2 extends ComplexExerciseItem {
  @override
  String name() {
    return "Wim Hof Method - Part 2";
  }

  @override
  List<String> steps() {
    return [
      "One minute breath hold from now on.",
      "Be in this moment.",
      "Let the body do what the body is capable of doing.",
      "Be aware of your heartbeat. Slow it down, and just be in this moment.",
      "Let that relaxation spread down to your toes, into your fingertips, to the base of your neck and head.",
    ];
  }

  @override
  int times() {
    return 1;
  }

  @override
  int inhaleTimeMs() {
    return 1;
  }

  @override
  int holdMiddleTimeMs() {
    return 1;
  }

  @override
  int exhaleTimeMs() {
    return 1;
  }

  @override
  int holdEndTimeMs() {
    return 60000;
  }
}

class _WimHofMethodExercisePt3 extends ComplexExerciseItem {
  @override
  String name() {
    return "Wim Hof Method - Part 3";
  }

  @override
  List<String> steps() {
    return [
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
  }

  @override
  int times() {
    return 30;
  }

  @override
  int inhaleTimeMs() {
    return 1562;
  }

  @override
  int holdMiddleTimeMs() {
    return 1;
  }

  @override
  int exhaleTimeMs() {
    return 1562;
  }

  @override
  int holdEndTimeMs() {
    return 1;
  }
}

class _WimHofMethodExercisePt4 extends ComplexExerciseItem {
  @override
  String name() {
    return "Wim Hof Method - Part 4";
  }

  @override
  List<String> steps() {
    return [
      "One a half minute breath hold from now on.",
      "Feel. Become aware of your body.",
      "If your hands and feet are tingling or you feel your body temperature is changing, that's ok.",
      "You're doing fantastic.",
      "If you need to breathe before I give the cue, that's okay",
    ];
  }

  @override
  int times() {
    return 1;
  }

  @override
  int inhaleTimeMs() {
    return 1;
  }

  @override
  int holdMiddleTimeMs() {
    return 1;
  }

  @override
  int exhaleTimeMs() {
    return 1;
  }

  @override
  int holdEndTimeMs() {
    return 90000;
  }
}

class _WimHofMethodExercisePt5 extends ComplexExerciseItem {
  @override
  String name() {
    return "Wim Hof Method - Part 5";
  }

  @override
  List<String> steps() {
    return [
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
  }

  @override
  int times() {
    return 30;
  }

  @override
  int inhaleTimeMs() {
    return 1562;
  }

  @override
  int holdMiddleTimeMs() {
    return 1;
  }

  @override
  int exhaleTimeMs() {
    return 1562;
  }

  @override
  int holdEndTimeMs() {
    return 1;
  }
}

class _WimHofMethodExercisePt6 extends ComplexExerciseItem {
  @override
  String name() {
    return "Wim Hof Method - Part 6";
  }

  @override
  List<String> steps() {
    return [
      "One and a half minute breath hold from now on.",
      "Become aware of the blood running through your veins, your heart beating. Feel.",
      "You are almost there.",
    ];
  }

  @override
  int times() {
    return 1;
  }

  @override
  int inhaleTimeMs() {
    return 1;
  }

  @override
  int holdMiddleTimeMs() {
    return 1;
  }

  @override
  int exhaleTimeMs() {
    return 1;
  }

  @override
  int holdEndTimeMs() {
    return 90000;
  }
}
