import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/exercise.dart';
import 'package:iremibreathingapp/utils/theme.dart';

import '../utils/defaultWidget.dart';
import '../utils/myUtils.dart';
import 'exercisePage.dart';

class ExerciseDetailsPages extends StatefulWidget {
  MyExercise exercise;

  ExerciseDetailsPages({Key? key, required this.exercise}) : super(key: key);

  @override
  State<ExerciseDetailsPages> createState() => _ExerciseDetailsPagesState();
}

class _ExerciseDetailsPagesState extends State<ExerciseDetailsPages>
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
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Details'),
            Tab(text: 'Steps'),
          ],
          indicatorColor: myBluNeutral,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _pages,
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
          defaultShowTextFormField(
              "Name", exercise.name, Icons.keyboard_double_arrow_up),
          defaultShowTextFormField(
              "Description", exercise.description, Icons.description),
          defaultShowTextFormField("notes", exercise.notes, Icons.note),
          defaultShowTextFormField("Inhale, hold, exhale, hold",
              getDurationString(exercise), Icons.book),
          defaultShowTextFormField("Times", "${exercise.times}", Icons.repeat),
          defaultShowTextFormField("Duration of exercise",
              getTimeString(exercise), Icons.timelapse_sharp),
        ],
      ),
      floatingActionButton: _startExercise(exercise, context),
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
            child: defaultShowTextFormField(step, "", Icons.shape_line),
          );
        },
      ),
      floatingActionButton: _startExercise(exercise, context),
    );
  }
}

FloatingActionButton _startExercise(MyExercise exercise, context){
  return  FloatingActionButton(
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