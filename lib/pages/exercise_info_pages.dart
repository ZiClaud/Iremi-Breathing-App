import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/exercise.dart';
import 'package:iremibreathingapp/database/database.dart';
import 'package:iremibreathingapp/pages/exercise_add_pages.dart';

import '../basics/exercise_custom.dart';
import '../utils/default_widgets.dart';
import '../utils/my_utils.dart';
import 'exercise_page.dart';
import 'home_page.dart';

class ExerciseInfoPages extends StatefulWidget {
  MyExercise exercise;

  ExerciseInfoPages({Key? key, required this.exercise}) : super(key: key);

  @override
  State<ExerciseInfoPages> createState() => _ExerciseInfoPagesState();
}

class _ExerciseInfoPagesState extends State<ExerciseInfoPages>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pages = [
      _ExerciseDetailsPage(exercise: widget.exercise),
      _ExerciseStepsPage(exercise: widget.exercise),
    ];
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
        title: Text(widget.exercise.name),
        bottom: defaultExerciseTopBar(_tabController),
        actions: [
          if (isDev && widget.exercise is CustomExercise)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseAddPages(
                        exercise: (widget.exercise as CustomExercise)),
                  ),
                ),
              },
            ),
          if (widget.exercise is CustomExercise)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => {_deleteExerciseWarning()},
            ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: _pages,
      ),
      floatingActionButton: _startExercise(widget.exercise, context),
    );
  }

  _deleteExerciseWarning() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete exercise"),
        content: const Text("Are you sure you want to delete this exercise?"),
        actions: [
          TextButton(
            child: defaultButtonText("Cancel"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: defaultButtonText("Delete"),
            onPressed: () async => {
              await DBCustomExercise()
                  .deleteExercise((widget.exercise as CustomExercise).id!),
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false,
              ),
            },
          ),
        ],
      ),
    );
  }
}

class _ExerciseDetailsPage extends StatefulWidget {
  MyExercise exercise;

  _ExerciseDetailsPage({Key? key, required MyExercise this.exercise})
      : super(key: key);

  @override
  State<_ExerciseDetailsPage> createState() => _ExerciseDetailsPageState();
}

class _ExerciseDetailsPageState extends State<_ExerciseDetailsPage> {
  @override
  Widget build(BuildContext context) {
    MyExercise exercise = widget.exercise;
    return Scaffold(
      body: ListView(
        children: [
          defaultInputDecorator(
              "Name", exercise.name, Icons.keyboard_double_arrow_up),
          defaultInputDecorator(
              "Description", exercise.description, Icons.description),
          defaultInputDecorator("notes", exercise.notes, Icons.note),
          defaultInputDecorator("Inhale, hold, exhale, hold",
              getDurationString(exercise), Icons.book),
          defaultInputDecorator("Times", "${exercise.times}", Icons.repeat),
          defaultInputDecorator("Duration of exercise", getTimeString(exercise),
              Icons.timelapse_sharp),
        ],
      ),
    );
  }
}

class _ExerciseStepsPage extends StatefulWidget {
  MyExercise exercise;

  _ExerciseStepsPage({Key? key, required MyExercise this.exercise})
      : super(key: key);

  @override
  State<_ExerciseStepsPage> createState() => _ExerciseStepsPageState();
}

class _ExerciseStepsPageState extends State<_ExerciseStepsPage> {
  @override
  Widget build(BuildContext context) {
    MyExercise exercise = widget.exercise;
    return Scaffold(
      body: ListView.builder(
        itemCount: exercise.steps.length,
        itemBuilder: (context, index) {
          String step = exercise.steps[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: defaultInputDecorator(
                "Step ${index + 1}", step, Icons.shape_line),
          );
        },
      ),
    );
  }
}

FloatingActionButton _startExercise(MyExercise exercise, context) {
  return FloatingActionButton(
    child: const Icon(Icons.play_arrow),
    onPressed: () => {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExercisePage(exercise: exercise),
        ),
      ),
    },
  );
}
