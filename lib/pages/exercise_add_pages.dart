import 'package:flutter/material.dart';
import 'package:iremibreathingapp/database/database.dart';
import 'package:iremibreathingapp/pages/home_page.dart';
import 'package:iremibreathingapp/utils/my_utils.dart';

import '../basics/badge.dart';
import '../basics/exercise_custom.dart';
import '../database/forms/exercise_form_widget.dart';
import '../utils/default_widgets.dart';

final TextEditingController _nameController = TextEditingController();
final TextEditingController _descriptionController = TextEditingController();
final TextEditingController _notesController = TextEditingController();
final TextEditingController _timesController = TextEditingController();
final TextEditingController _inhaleDurationController = TextEditingController();
final TextEditingController _inhaleDurationMsController =
    TextEditingController();
final TextEditingController _holdMiddleDurationController =
    TextEditingController();
final TextEditingController _holdMiddleDurationMsController =
    TextEditingController();
final TextEditingController _exhaleDurationController = TextEditingController();
final TextEditingController _exhaleDurationMsController =
    TextEditingController();
final TextEditingController _holdEndDurationController =
    TextEditingController();
final TextEditingController _holdEndDurationMsController =
    TextEditingController();
final List<TextEditingController> _stepsControllers = [];
final List<FocusNode> _stepsFocusNodes = [];

class ExerciseAddPages extends StatefulWidget {
  CustomExercise? exercise; // TODO: Use it to modify the exercise
  ExerciseAddPages({Key? key, this.exercise}) : super(key: key);

  @override
  State<ExerciseAddPages> createState() => _ExerciseAddPagesState();
}

class _ExerciseAddPagesState extends State<ExerciseAddPages>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final List<Widget> _pages;

  final formData = ExerciseFormData();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pages = [
      _ExerciseAddDetailsPage(
        formData: formData,
      ),
      _ExerciseAddStepsPage(
        formData: formData,
      ),
    ];
    _nameController.text = "";
    _descriptionController.text = "";
    _notesController.text = "";
    _timesController.text = "";
    _inhaleDurationController.text = "";
    _inhaleDurationMsController.text = "";
    _holdMiddleDurationController.text = "";
    _holdMiddleDurationMsController.text = "";
    _exhaleDurationController.text = "";
    _exhaleDurationMsController.text = "";
    _holdEndDurationController.text = "";
    _holdEndDurationMsController.text = "";
    _stepsControllers.clear();
    _stepsFocusNodes.clear();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add custom exercise"),
        bottom: defaultTopBar(_tabController),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _pages,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.navigate_next),
        onPressed: () {
          _customizerAchievement(context);
          try {
            _saveExercise(context);
          } catch (e) {
            defaultDatabaseErrorDialog(context, e.toString());
          }
        },
      ),
    );
  }

  void _customizerAchievement(BuildContext context) {
    Achievement.addAchievement(PossibleBadges.customizer, context);
  }

  void _saveExercise(BuildContext context) {
    // TODO: Fix "Steps" -> they don't work at all
    if (formData.name == null || formData.name!.isEmpty) {
      throw Exception("Please enter a name for the exercise");
    }
    if (formData.times == null || formData.times! <= 0) {
      throw Exception("Please enter a valid number of times");
    }

    int inhaleDuration = formData.inhaleDuration ?? 0;
    int inhaleDurationMs = formData.inhaleDurationMs ?? 0;
    if (inhaleDuration == 0 && inhaleDurationMs == 0) {
      inhaleDurationMs = 1;
    }

    int holdMiddleDuration = formData.holdMiddleDuration ?? 0;
    int holdMiddleDurationMs = formData.holdMiddleDurationMs ?? 0;
    if (holdMiddleDuration == 0 && holdMiddleDurationMs == 0) {
      holdMiddleDurationMs = 1;
    }

    int exhaleDuration = formData.exhaleDuration ?? 0;
    int exhaleDurationMs = formData.exhaleDurationMs ?? 0;
    if (exhaleDuration == 0 && exhaleDurationMs == 0) {
      exhaleDurationMs = 1;
    }

    int holdEndDuration = formData.holdEndDuration ?? 0;
    int holdEndDurationMs = formData.holdEndDurationMs ?? 0;
    if (holdEndDuration == 0 && holdEndDurationMs == 0) {
      holdEndDurationMs = 1;
    }

    final newExercise = CustomExercise(
      name: formData.name!,
      description: formData.description ?? "",
      notes: formData.notes ?? "",
      times: formData.times!,
      inhaleTimeMs: inhaleDuration * 1000 + inhaleDurationMs,
      holdMiddleTimeMs: holdMiddleDuration * 1000 + holdMiddleDurationMs,
      exhaleTimeMs: exhaleDuration * 1000 + exhaleDurationMs,
      holdEndTimeMs: holdEndDuration * 1000 + holdEndDurationMs,
      steps: formData.steps,
    );

    try {
      DBCustomExercise().createExercise(newExercise);
    } catch (e) {
      rethrow;
    } finally {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    }
  }
}

class _ExerciseAddDetailsPage extends StatefulWidget {
  bool showComplex = false;
  final ExerciseFormData formData;

  _ExerciseAddDetailsPage({Key? key, required this.formData}) : super(key: key);

  @override
  State<_ExerciseAddDetailsPage> createState() =>
      _ExerciseAddDetailsPageState();
}

class _ExerciseAddDetailsPageState extends State<_ExerciseAddDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          defaultEditTextFormField2(
            "Name",
            Icons.keyboard_double_arrow_up,
            _nameController,
            onChanged: (value) {
              widget.formData.name = value;
            },
          ),
          defaultEditTextFormField2(
            "Description",
            Icons.description,
            _descriptionController,
            onChanged: (value) {
              widget.formData.description = value;
            },
          ),
          defaultEditTextFormField2(
            "Notes",
            Icons.note,
            _notesController,
            onChanged: (value) {
              widget.formData.notes = value;
            },
          ),
          defaultEditTextFormField2Num(
            "Times",
            Icons.incomplete_circle,
            _timesController,
            onChanged: (value) {
              widget.formData.times = int.tryParse(value!) ?? 0;
            },
          ),
          defaultEditTextFormField2Num(
            "InhaleDuration",
            Icons.circle,
            _inhaleDurationController,
            onChanged: (value) {
              widget.formData.inhaleDuration = int.tryParse(value!) ?? 0;
            },
          ),
          defaultEditTextFormField2Num(
            "HoldMiddleDuration",
            Icons.change_circle,
            _holdMiddleDurationController,
            onChanged: (value) {
              widget.formData.holdMiddleDuration = int.tryParse(value!) ?? 0;
            },
          ),
          defaultEditTextFormField2Num(
            "ExhaleDuration",
            Icons.circle_outlined,
            _exhaleDurationController,
            onChanged: (value) {
              widget.formData.exhaleDuration = int.tryParse(value!) ?? 0;
            },
          ),
          defaultEditTextFormField2Num(
            "HoldEndDuration",
            Icons.change_circle_outlined,
            _holdEndDurationController,
            onChanged: (value) {
              widget.formData.holdEndDuration = int.tryParse(value!) ?? 0;
            },
          ),
          if (widget.showComplex)
            defaultEditTextFormField2Num(
              "InhaleDuration (ms)",
              Icons.circle,
              _inhaleDurationMsController,
              onChanged: (value) {
                widget.formData.inhaleDurationMs = int.tryParse(value!) ?? 0;
              },
            ),
          if (widget.showComplex)
            defaultEditTextFormField2Num(
              "HoldMiddleDuration (ms)",
              Icons.change_circle,
              _holdMiddleDurationMsController,
              onChanged: (value) {
                widget.formData.holdMiddleDurationMs =
                    int.tryParse(value!) ?? 0;
              },
            ),
          if (widget.showComplex)
            defaultEditTextFormField2Num(
              "ExhaleDuration (ms)",
              Icons.circle_outlined,
              _exhaleDurationMsController,
              onChanged: (value) {
                widget.formData.exhaleDurationMs = int.tryParse(value!) ?? 0;
              },
            ),
          if (widget.showComplex)
            defaultEditTextFormField2Num(
              "HoldEndDuration (ms)",
              Icons.change_circle_outlined,
              _holdEndDurationMsController,
              onChanged: (value) {
                widget.formData.holdEndDurationMs = int.tryParse(value!) ?? 0;
              },
            ),
          if (!widget.showComplex)
            OutlinedButton(
              onPressed: () {
                setState(() {
                  widget.showComplex = true;
                });
              },
              child: defaultButtonText('Show More'),
            ),
          if (widget.showComplex)
            OutlinedButton(
              onPressed: () {
                setState(() {
                  widget.showComplex = false;
                });
              },
              child: defaultButtonText('Show Less'),
            ),
        ],
      ),
    );
  }
}

class _ExerciseAddStepsPage extends StatefulWidget {
  final ExerciseFormData formData;

  const _ExerciseAddStepsPage({Key? key, required this.formData})
      : super(key: key);

  @override
  State<_ExerciseAddStepsPage> createState() => _ExerciseAddStepsPageState();
}

class _ExerciseAddStepsPageState extends State<_ExerciseAddStepsPage> {
  @override
  void initState() {
    super.initState();
//    _addTextFormField();
  }

  @override
  void dispose() {
//    _stepsControllers.forEach((controller) => controller.dispose());
//    _stepsFocusNodes.forEach((focusNode) => focusNode.dispose());
    super.dispose();
  }

  void _addTextFormField() {
    final controller = TextEditingController();
    final focusNode = FocusNode();
    setState(() {
      _stepsControllers.add(controller);
      _stepsFocusNodes.add(focusNode);
    });
    // After adding a new text field, set the focus to it.
    Future.delayed(
        Duration.zero, () => FocusScope.of(context).requestFocus(focusNode));
  }

  void _removeTextFormField(int index) {
    setState(() {
      _stepsControllers.removeAt(index);
      _stepsFocusNodes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < _stepsControllers.length; i++)
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _stepsControllers[i],
                      focusNode: _stepsFocusNodes[i],
                      decoration: InputDecoration(
                        labelText: 'Step ${i + 1}',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removeTextFormField(i),
                  ),
                ],
              ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addTextFormField,
              child: defaultButtonText('Add Step'),
            ),
          ],
        ),
      ),
    );
  }
}
